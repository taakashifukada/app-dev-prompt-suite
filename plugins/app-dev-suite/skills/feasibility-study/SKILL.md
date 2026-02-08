---
name: feasibility-study
description: Read a spec document and conduct a deep feasibility study with deep codebase analysis, web research, and PoC prototyping.
argument-hint: [message]
allowed-tools: Read, Grep, Glob, Write(.claude/claudeRes/*)
skills:
  - quality-gate
---

Conduct a feasibility study based on the spec at `config.feature_spec.path` (default: `.claude/claudeRes/scripts/feature_spec.md`).

## Steps

### 0. Initialization
- Load config: see [conventions](../../conventions.md)
- Check for `progress.yaml` in output_dir; if found: AskUserQuestion — resume / start fresh / Type Anything
- Initialize metrics tracker for this task

### 1. Task Name and Output Path
- Format task name per `config.task_naming.pattern` (default: `{type}-{jira_id}-{brief_desc}`)
  - If `config.task_naming.jira.enabled`: AskUserQuestion for JIRA ID
  - If JIRA disabled: use `{type}-{brief_desc}` pattern
- Output path: `{output_dir}/{task_name}/feasibility_report.md`
- TaskCreate: `Feasibility Study: <task-name>`

### 2. Ultrathink Mode
AskUserQuestion: use ultrathink for deep analysis? (Yes / No)

### 3. Codebase & Research Investigation (parallel)
Read [investigation instructions](steps/investigation.md) and execute.
Update metrics: `files_analyzed` count.

### 4. Clarification
AskUserQuestion for any unclear requirements.

### 5. Solution Candidates
Build list of implementation approach candidates.

### 6. Candidate Summary
Use document-summarizer agent to create max 100-line summary of candidates.
Display to user. Update metrics: `solution_candidates` count.

### 7. Approach Selection
Read [approach selection instructions](steps/approach-selection.md) and execute.

### 8. Final Report
Use document-summarizer to create max 100-line summary.
Save hierarchical docs:
- `{docs_dir}/{task_name}/feasibility_report.md` — summary (max 100 lines), format per `report-format.md`
- `{docs_dir}/{task_name}/feasibility_details/` — see `details-format.md`

### 9. Quality Gate
- Create feasibility_study checklist (via quality-gate skill)
- Attach evidence: analyzed file paths, URLs consulted, candidate names
- Present checklist with evidence to user
- AskUserQuestion — gate decision: Pass / Warn / Block / Type Anything
- Block → fix issues; Warn → record concerns, proceed

### 10. Metrics & Completion
- Record completion timestamp and save metrics report
- Display metrics summary
- TaskUpdate: mark completed
- TaskCreate: `Solution Design: <task-name>` as next step
- Update `progress.yaml`: set feasibility_study to completed, record output path
- Display next phase command:
  ```
  Next: /app-dev-suite:solution-design -s {path-to-feasibility-report}
  ```
- AskUserQuestion: proceed to next phase? (Yes: copy and run the command above / No: run later / Type Anything)

## Constraints

- DRY: reuse existing code
- Docs dir: `config.documents.output_dir` (default: `.claude/claudeRes/docs`)
- Document language: `config.documents.language` (see [conventions](../../conventions.md))
