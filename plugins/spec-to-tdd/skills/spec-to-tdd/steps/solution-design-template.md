> Structural reference.

````markdown
# Solution Design: {task-name}

**Created:** {YY_MM_DD}
**Spec:** `{path-to-feature-spec}`

## Requirements
{Distilled from Phase 1. State each as a testable behavior.}

## Investigation Summary
{Key findings from Phase 1-2:
- Existing patterns/conventions that constrain the solution
- Reusable modules/functions with file paths
- Risks or constraints identified}

## Implementation Strategy
{Chosen approach. Reference architectural patterns found during investigation.}

## Detailed Change List
| File | Action | Description |
|------|--------|-------------|
| `{path}` | new/modify/delete | {what and why} |

## Subtask List

### Subtask 1: {title}
- **Description**: {behavioral description}
- **Target files**: `{path}` (new/modify)
- **Reuse**: `{function}` from `{path}`
- **Acceptance criteria**:
  - [ ] {testable criterion}

## Precedence Diagram
```mermaid
graph LR
  1[Subtask 1] --> 2[Subtask 2]
```
````
