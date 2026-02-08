---
name: implement-tdd
description: Implement feature/bugfix/tech improvement based on a solution design document with a TDD approach
argument-hint: [-s|--source <solution-design-file-path>]
allowed-tools: Read, Grep, Glob, Write, Edit
skills:
  - quality-gate
---

Implement the solution design using TDD (Red-Green-Refactor).

## Steps

### 0. Initialization
- Load config: see [conventions](../../conventions.md)
- Load metrics tracker

### 1. Source Design
- Parse `-s|--source <path>` from arguments
- If not specified: Glob for `**/*solution_design*.md` in output_dir, sort by mtime, present candidates

### 2. Previous Task Check
- TaskList: find `Solution Design: <task-name>`, mark completed
- If incomplete: AskUserQuestion — continue or abort

### 3. New Task
TaskCreate: `TDD Implementation: <task-name>`

### 4. Read Solution Design
- Read summary; load subtask details and dependencies from `solution_details/`
- AskUserQuestion if information is insufficient

### 5. Branch Setup
Propose branch name and base; create or wait for user to create. Checkout.

### 6. Subtask Implementation Loop
Read [subtask loop instructions](steps/subtask-loop.md) and execute for each subtask in dependency order.

### 7. Integration Verification
- Run all tests; confirm passing
- Run integration tests
- Update metrics: `tests_added`

### 8. Implementation Report
Save to `{docs_dir}/{task_name}/implementation_report.md`:
- Summary of what was implemented
- Subtask completion status
- Issues encountered and resolutions
- Append PR Description: Background / Main Changes / Notes (3-10 lines each)

### 9. Quality Gate
- Create implementation checklist (via quality-gate skill)
- Display for user approval; evaluate gate

### 10. Metrics & Completion
- Save metrics report; display summary
- TaskUpdate: mark completed

## Constraints

- TDD overkill → inform user, get approval for simpler approach
- Docs dir: `config.documents.output_dir` (default: `.claude/claudeRes/docs`)
- Document language: `config.documents.language` (see [conventions](../../conventions.md))
