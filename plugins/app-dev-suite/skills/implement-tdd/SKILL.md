---
name: implement-tdd
description: Implement feature/bugfix/tech improvement based on a solution design document with a TDD approach
argument-hint: [-s|--source <solution-design-file-path>]
allowed-tools: Read, Grep, Glob, Write, Edit
---

Implement the solution design using TDD (Red-Green-Refactor).

## Role: Implementation Orchestrator

You are an orchestrator. You design, plan, coordinate, and verify -- you never implement.

### Write Scope

You use Write and Edit tools exclusively for:
- Design documents (`solution_details/`, `subtask_<N>.md`)
- Progress tracking (`progress.yaml`, metrics)
- Reports (`implementation_report.md`)

You never use Write or Edit for production/test source code or build configuration files.

### Delegation Rule

All code changes go through the tdd-implementer agent via the Task tool. No exceptions.
When the user provides implementation feedback mid-process, follow the User Feedback Routing protocol in subtask-loop.md.

## Steps

### 0. Initialization
- Load config: see [conventions](../../conventions.md)
- Check for `progress.yaml` in output_dir; if found: AskUserQuestion — resume / start fresh / Type Anything
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
- Propose main implementation branch name (e.g. `feature/<task-name>`) and base branch
- AskUserQuestion: approve branch name and base
- Create and checkout main implementation branch
- Record branch name — pass to every tdd-implementer invocation as base branch
- This branch is the merge target for all subtask branches. Never commit implementation code to this branch directly.

### 6. Subtask Implementation Loop
Read [subtask loop instructions](steps/subtask-loop.md) and execute for each subtask in dependency order.

### 7. Integration Verification
- Run all tests; capture full output (exit code + summary)
- Run integration tests; capture full output
- Update metrics: `tests_added`
- Retain test outputs as evidence for quality gate (`tests_passing`, `test_coverage`)

### 8. Implementation Report
Save to `{docs_dir}/{task_name}/implementation_report.md`:
- Summary of what was implemented
- Subtask completion status
- Issues encountered and resolutions
- Append PR Description: Background / Main Changes / Notes (3-10 lines each)

### 9. Quality Gate
- Launch quality-gate-evaluator agent with: phase=implementation, docs_dir, task_name, thresholds from config
- Agent independently reads artifacts, collects evidence (test output from Step 7, git diff), evaluates against thresholds
- Agent returns: structured quality report with recommendation
- Present report to user
- AskUserQuestion — gate decision: Pass / Warn / Block / Type Anything
- Block → fix issues; Warn → record concerns, proceed

### 10. Metrics & Completion
- Save metrics report; display summary
- Update `progress.yaml`: set implementation to completed, record output path
- TaskUpdate: mark completed

## Constraints

- TDD overkill → inform user, get approval for simpler approach
- Docs dir: `config.documents.output_dir` (default: `.claude/claudeRes/docs`)
- Document language: `config.documents.language` (see [conventions](../../conventions.md))
- Orchestrator boundary: never write or edit production/test source code directly. All code changes are delegated to tdd-implementer via the Task tool.
- User feedback during implementation: follow User Feedback Routing in subtask-loop.md Phase b. Capture → update design → re-delegate. Never implement directly.
- Branch discipline: the orchestrator never commits code to the main implementation branch. All code arrives via subtask branch merges performed by tdd-implementer after user approval.
- Remote push prohibition: never push to remote or merge the main implementation branch into other branches. The user handles this via pull request.
