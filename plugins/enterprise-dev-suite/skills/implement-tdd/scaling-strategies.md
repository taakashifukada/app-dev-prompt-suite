# Scaling Strategies for 20+ Subtasks

When `subtask_count` exceeds 20:

## Subtask Grouping

Group related subtasks by logical unit (e.g., "Authentication", "UI Components", "Data Layer").
- Design, implement, and review per group
- Document group-level dependencies
- Common implementation approach per group

## Batch Design

Design similar-pattern subtasks together:
- Define common approach first
- Document shared components
- Per-subtask: only variations
- Shared test strategy

## Progressive Disclosure

Always applied for large task sets:
1. Detailed design for high-priority subtasks first
2. Implement and learn
3. Design next batch incorporating learnings
4. Repeat until all subtasks complete
