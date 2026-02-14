# Synthesis

Integrate all task findings into a coherent research report.

## Procedure

### 1. Load Findings
- Read `accumulated_findings.md` (all key findings)
- Read `research_context.md` (dimensions list)
- Read `adaptation_log.md` if exists (plan evolution)

### 2. Build Cross-Reference Matrix
For each research dimension:
- Identify which tasks contributed findings
- Extract consensus points (findings supported by multiple tasks)
- Flag contradictions (conflicting findings across tasks)
- Identify gaps (dimensions with insufficient coverage)

### 3. Completeness Assessment
For each research dimension, rate coverage:
- **Sufficient**: Multiple corroborating sources, high-confidence findings
- **Partial**: Some findings but gaps in depth or breadth
- **Insufficient**: No meaningful findings

Only dimensions rated Partial or Insufficient proceed to Step 4.

### 4. Fill Coverage Gaps
If critical gaps exist:
- Create ad-hoc task definitions for gap-filling
- For each gap task, launch a Task tool subagent (`subagent_type: general-purpose`, `model: sonnet`) with the same investigator-prompt.md pattern:
  ```
  {investigator-prompt.md contents}

  ## Research Context
  {research_context.md contents}

  ## Your Task
  {gap_task_definition}

  ## Prior Investigation Findings
  {accumulated_findings.md contents}

  ## Output
  - Full result: {absolute path to result file}
  - Key findings only: {absolute path to key findings file}
  ```
- Append new key findings to accumulated_findings.md

### 5. Synthesize
For deeper analysis, Read individual `{task_id}_result.md` files (the `## Detailed Findings` section) as needed. Then:
- Identify cross-cutting patterns
- Draw connections between dimensions
- Formulate actionable recommendations
- Assess overall confidence

### 6. Generate Report
Write `research_report.md` following [report format](../report-format.md).
