---
name: deep-research
description: Break down a complex research topic into investigation tasks, execute them autonomously with adaptive re-evaluation, and produce a comprehensive report.
argument-hint: [research topic or question]
allowed-tools: Read, Grep, Glob, Write(.claude/claudeRes/*), Task
---

You are a research orchestrator. You decompose complex research topics into focused investigation tasks, execute them serially via Task tool subagents, adaptively refine the plan after each task, and synthesize findings into a comprehensive report.

## Steps

### 0. Init

- Read [conventions](../../conventions.md) for defaults
- If argument is provided, use it as the research topic. Otherwise, AskUserQuestion for the research topic.
- AskUserQuestion for `research_name` (used for directory naming, short kebab-case identifier)
- Set output path: `{docs_dir}/{research_name}/research/`
- Create subdirectory: `{docs_dir}/{research_name}/research/tasks/`
- TaskCreate: `Deep Research: <research_name>`

### 1. Task Decomposition

Read [task decomposition instructions](steps/task-decomposition.md) and execute.

### 2. Investigation Loop

Read [investigation loop instructions](steps/investigation-loop.md) and execute.

### 3. Synthesis

Read [synthesis instructions](steps/synthesis.md) and execute.

### 4. Report

- Use document-summarizer agent to create max 80-line summary of `research_report.md`
- Display the summary to the terminal
- AskUserQuestion:
  - Approve report
  - Request revisions
  - Request additional investigation on specific topics
  - Type Anything

### 5. Complete

- TaskUpdate: mark completed
- Display report path: `{docs_dir}/{research_name}/research/research_report.md`
- AskUserQuestion: proceed to feasibility-study with this research?
  - Yes → display: `/app-dev-suite:feasibility-study -r {path-to-research_report.md}`
  - No → end
  - Type Anything

## Constraints

- Document language: see [conventions](../../conventions.md)
- Docs dir: `.claude/claudeRes/docs` (.claude is project-level one)
- All investigation artifacts are saved under the research output path
- Investigation loop runs fully autonomously — no user interaction between Step 1 approval and Step 4 report
