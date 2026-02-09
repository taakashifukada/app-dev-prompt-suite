# Subtask Implementation Loop

For each subtask (in dependency order):

## a. Detailed Design

- Read subtask info from `design/solution_design.md`
- If needed: launch Explore agent for deeper file investigation
- Define detailed unit/integration test cases
- **Scaling (20+ subtasks):** apply grouping or batch design per [scaling-strategies.md](../scaling-strategies.md)
- AskUserQuestion: approve detailed design

## b. TDD Implementation

Delegate to tdd-implementer agent via the Task tool with:
- Detailed design content (included directly in the prompt)
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
3. **Update design** -- Revise detailed design
4. **Re-delegate** -- Launch new tdd-implementer Task with updated design
5. **Never implement the feedback yourself** -- Even if trivial

### Re-anchoring Checkpoint

After any user interruption during Phase b, before taking action, re-read this rule:
You are the orchestrator. You design and delegate. The tdd-implementer implements.

- TDD cycle: Red → Green → Refactor (executed by tdd-implementer)
- Capture test runner output (exit code + summary) after Green phase

## c. Subtask Retrospective

- Record design↔implementation gaps
- Log issues to `implementation/implementation_report.md` → `## Issues Found During Implementation`
