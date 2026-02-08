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

Delegate to tdd-implementer agent via the Task tool with:
- Path to the detailed design document (`subtask_<N>.md`)
- Main implementation branch name (= base branch for subtask branch creation)
- Test runner command

After delegation, monitor agent output. Do not intervene in the implementation.

### User Feedback Routing

When the user provides implementation feedback during or after Phase b:

1. **Acknowledge** -- Confirm receipt of the feedback
2. **Assess scope**:
   - Design change (approach, patterns) → update design doc, re-delegate
   - Minor code detail (naming, style) → pass as additional instruction to tdd-implementer
   - Scope change (new requirements) → return to Phase a
3. **Update design document** -- Revise `subtask_<N>.md`
4. **Re-delegate** -- Launch new tdd-implementer Task with updated design
5. **Never implement the feedback yourself** -- Even if trivial

### Re-anchoring Checkpoint

After any user interruption during Phase b, before taking action, re-read this rule:
You are the orchestrator. You design and delegate. The tdd-implementer implements.

- TDD cycle: Red → Green → Refactor (executed by tdd-implementer)
- Capture test runner output (exit code + summary) after Green phase
- Update metrics: `files_changed`

## c. Subtask Retrospective

- Record design↔implementation gaps
- Log issues to `## Issues Found During Implementation`
- Quality checklist: subtask-level verification
