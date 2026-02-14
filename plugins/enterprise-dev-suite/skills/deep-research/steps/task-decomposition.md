# Task Decomposition

Break down the research topic into focused investigation tasks.

## Procedure

### 1. Analyze Research Topic
- Identify the core question and its scope
- Extract **research dimensions** (distinct perspectives/concerns to investigate)
- Number each dimension: D1, D2, ...

### 2. Design Investigation Tasks
Create tasks that collectively cover all dimensions. Scale task count to topic complexity:
- Narrow, well-defined topic: 3-4 tasks
- Multi-faceted topic with clear dimensions: 5-6 tasks
- Broad, cross-disciplinary topic: 7-8 tasks

For each task:

```markdown
# {task_id}: {title}

- **method**: {web-research | codebase-analysis | comparative | synthesis-subtask | custom-tool}
- **covers_dimensions**: {comma-separated dimension numbers}

## Question
{The specific question this task must answer}

## Guidance
{Specific instructions, search terms, or focus areas}

## Scope
- **In scope**: {what this task covers}
- **Out of scope**: {what this task explicitly excludes}
- **Expected depth**: {surface overview | detailed analysis}
```

Task design principles:
- Each task answers ONE specific question
- Order tasks so earlier ones inform later ones (serial execution)
- Place broad/foundational tasks first, specialized/synthesis tasks later
- Every dimension must be covered by at least one task
- Use `synthesis-subtask` for tasks that integrate findings from prior tasks
- If custom tools are listed in the Available Custom Tools section, evaluate each tool's relevance to the research dimensions. Assign `custom-tool` method to tasks where a custom tool is the best fit, and include `tool_name: {Name}` in the task's Guidance section

### 3. Save Files
- Save each task definition: `tasks/{task_id}_definition.md`
- Save `research_context.md`:
  ```markdown
  # Research Context
  ## Topic
  {research topic as stated by user}
  ## Dimensions
  - D1: {description}
  - D2: {description}
  ...
  ```
- Save `task_order.txt`: one task ID per line, in execution order

### 4. Present to User
- Use document-summarizer agent (max 30 lines) to summarize the task list
- Display the summary

### 5. Get Approval
- AskUserQuestion:
  - Approve and start investigation
  - Modify task scope or questions
  - Add or remove tasks
  - Type Anything
