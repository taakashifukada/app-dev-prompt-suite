# Subtask Implementation Loop

For each subtask (in dependency order):

## a. Detailed Design

- Read subtask overview from `solution_details/subtasks.md`
- If needed: launch Explore agent for deeper file investigation
- Define detailed unit/integration test cases
- Use subtask design template (read from `solution-design/subtask-design-template.md` if config enables templates)
- **Scaling (20+ subtasks):** apply grouping or batch design per [scaling-strategies.md](../scaling-strategies.md)
- Save: `{docs_dir}/{task_name}/solution_details/file_changes/subtask_<N>.md`
- AskUserQuestion: approve detailed design

## b. TDD Implementation

- Delegate to tdd-implementer agent with the detailed design
- TDD cycle: Red → Green → Refactor
- Update metrics: `files_changed`

## c. Subtask Retrospective

- Record design↔implementation gaps
- Log issues to `## Issues Found During Implementation`
- Quality checklist: subtask-level verification
