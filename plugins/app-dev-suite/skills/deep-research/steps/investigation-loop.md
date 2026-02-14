# Investigation Loop

Execute investigation tasks serially via Task tool subagents with adaptive re-evaluation after each task.

## Procedure

Re-read `task_order.txt` at the start of each iteration to pick up adaptation changes.

For each `task_id` in `task_order.txt`:

### 1. Skip Completed

If `tasks/{task_id}_result.md` already exists, skip to the next task.

### 2. Investigate

Launch a Task tool subagent (`subagent_type: general-purpose`) with the following prompt assembled by reading each file:

```
{investigator-prompt.md contents}

## Research Context
{research_context.md contents}

## Your Task
{tasks/{task_id}_definition.md contents}

## Prior Investigation Findings
{accumulated_findings.md contents}

## Output
- Full result: {absolute path to tasks/{task_id}_result.md}
- Key findings only: {absolute path to tasks/{task_id}_key_findings.md}
```

### 3. Accumulate Findings

After the subagent completes:
1. If `tasks/{task_id}_result.md` does not exist, log a warning and continue to next task
2. Read `tasks/{task_id}_key_findings.md`
3. Append to `accumulated_findings.md` with a `### {task_id}` header using the Write tool

### 4. Adapt Remaining Tasks

Count remaining incomplete tasks (no `_result.md` file). If none remain, exit the loop.

Otherwise, launch a Task tool subagent (`subagent_type: general-purpose`) with:

```
{adaptation-prompt.md contents}

## Research Context
{research_context.md contents}

## Accumulated Findings
{accumulated_findings.md contents}

## Remaining Tasks
{concatenated contents of each remaining {task_id}_definition.md, separated by ---}

## Writable Files
- Task definitions: {absolute path to tasks/}
- Task order: {absolute path to task_order.txt}
- Adaptation log: {absolute path to adaptation_log.md}
```

### 5. Loop

Return to the top of the loop (re-read `task_order.txt`).

## Completion

When all tasks in `task_order.txt` have `_result.md` files, the loop ends.
