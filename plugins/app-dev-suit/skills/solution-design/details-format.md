> Structural reference. Adapt headings to `config.documents.language`.

# Solution Details Format

## test_cases.md

```markdown
# Test Cases: {task-name}

## TC-1: {name}
- **Behavior:** {user action and system response}
- **Expected:** {result}
- **Related subtasks:** [1, 3, 5]

## Test Case ↔ Subtask Mapping

| Test Case | Subtasks | Priority |
|-----------|----------|----------|
| TC-1 | 1, 3, 5 | High |
| TC-2 | 2, 4 | Medium |

Note: Detailed unit tests defined during implementation.
```

## subtasks.md

```markdown
# Subtask Details: {task-name}

## Subtask 1: {name}

### Overview
{purpose and summary}

### Dependencies
- Blocks: [2, 3]
- Blocked by: []

### Implementation Scope
- Files: {file1}, {file2}
- Estimated: 1-2h

### Acceptance Criteria
- [ ] {criterion 1}
- [ ] {criterion 2}

### Test Strategy
{types of tests for this subtask}
```

## file_changes/subtask_N.md

```markdown
# File Changes: Subtask N

## File: {path}

### Current State
{current implementation}

### Planned Changes
{what will change}

### Impact
{scope of this change}
```
