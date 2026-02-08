# Subtask Breakdown

1. Split the solution into subtasks based on:
   - Logical boundaries (data / domain / UI layers)
   - Dependency ordering (independent tasks first)
   - Testability (each subtask independently testable)

2. For each subtask define:
   - Name and summary
   - Estimated effort
   - Dependencies (blocks / blocked-by)
   - Implementation scope (files to modify)
   - Acceptance criteria

3. Create a Mermaid precedence diagram showing dependency flow

4. Update metrics: `subtask_count`, `dependency_depth`

5. If subtask count exceeds `config.quality.thresholds.solution_design.max_subtask_count`:
   apply scaling strategies from [scaling-strategies.md](../../implement-tdd/scaling-strategies.md)
