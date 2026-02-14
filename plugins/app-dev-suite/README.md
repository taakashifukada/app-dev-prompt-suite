# app-dev-suite

A Claude Code plugin providing deep research and a three-phase spec-driven development workflow: deep research, feasibility study, solution design, and TDD implementation.

## Installation

### Via Marketplace (Recommended)

```bash
# Add marketplace
/plugin marketplace add taakashifukada/app-dev-prompt-suite

# Install plugin
/plugin install app-dev-suite@app-dev-prompt-suite
```

### From Local Directory

```bash
claude --plugin-dir ./app-dev-suite-plugin
```

After installation, skills are accessible with the `app-dev-suite:` namespace prefix:
```
/app-dev-suite:deep-research        # Optional: autonomous deep research
/app-dev-suite:feasibility-study    # Phase 1
/app-dev-suite:solution-design      # Phase 2
/app-dev-suite:implement-tdd        # Phase 3
/app-dev-suite:small-feature        # Quick all-in-one
/app-dev-suite:generate-slides      # Slide generation
```

## Overview

app-dev-suite is a structured development workflow plugin for teams that need **process transparency** and **decision traceability** — capabilities that Claude Code's built-in Plan Mode does not provide.

### Workflow

0. **Deep Research** (optional) — Autonomous multi-task investigation with adaptive re-evaluation, feeds into feasibility study via `-r` flag
1. **Feasibility Study** — Codebase analysis, web research, solution candidates, and optional PoC
2. **Solution Design** — Subtask breakdown, dependency mapping, test case planning
3. **TDD Implementation** — Test-driven development with per-subtask verification

Each phase produces a structured document that serves as an audit trail and team-shareable artifact.

### Design Philosophy

app-dev-suite is built for **spec-driven implementation on enterprise-scale codebases** — where process transparency, correctability at key decision points, and output consistency matter.

- **Process transparency**: Every phase produces structured, reviewable artifacts with decision rationale
- **Correctability**: User approval at key decision points lets teams course-correct before work compounds
- **Output consistency**: Templates ensure uniform document structure regardless of session or model variance
- **Sonnet-optimized**: Workflow and prompts are designed to produce reliable results with Claude Sonnet, keeping Opus optional for deep analysis

### Why app-dev-suite over Plan Mode?

| | Plan Mode | app-dev-suite |
|---|---|---|
| **Workflow** | User designs ad-hoc each time | Pre-built 3-phase with user approval gates |
| **Artifact persistence** | Confined to conversation | File output per phase, resumable across sessions |
| **Decision records** | Not retained unless explicitly instructed | Built into workflow via feasibility report |
| **Correctability** | None | User approval at every key decision point |
| **Output consistency** | Varies per run | Unified structure via templates, multi-language support |
| **Specialized agents** | General-purpose subagents only | 5 dedicated agents + autonomous deep research via Task tool subagents |

**Best fit**: Teams working on large codebases where development decisions need to be reviewed by stakeholders — why this design was chosen and what alternatives were considered.

For quick individual tasks, Plan Mode or `/app-dev-suite:small-feature` remains the simpler choice.

## Quick Start

### Basic Usage (No Configuration Required)

```
/app-dev-suite:deep-research        # Optional: deep research before feasibility
/app-dev-suite:feasibility-study    # Phase 1
/app-dev-suite:solution-design      # Phase 2
/app-dev-suite:implement-tdd        # Phase 3
```

### With Deep Research

```
/app-dev-suite:deep-research "MCP server integration patterns"
# → Produces research_report.md
# Then feed into feasibility study:
/app-dev-suite:feasibility-study -r {path-to-research_report.md}
```

### Quick Implementation

For smaller tasks that don't need the full three-phase workflow:
```
/app-dev-suite:small-feature
```

## Skills

| Skill | Description |
|-------|-------------|
| `deep-research` | Autonomous multi-task investigation with adaptive re-evaluation |
| `feasibility-study` | Codebase analysis, web research, solution candidates, PoC |
| `solution-design` | Subtask breakdown, test cases, precedence diagram |
| `implement-tdd` | TDD implementation per subtask |
| `small-feature` | All-in-one quick implementation with TDD |
| `generate-slides` | Marp presentation slides from phase artifacts |

## Agents

| Agent | Purpose |
|-------|---------|
| `codebase-investigator` | 3-phase iterative codebase exploration |
| `poc-feasibility-expert` | PoC implementation and validation |
| `tdd-implementer` | TDD-based implementation |
| `web-research-expert` | Technical research and documentation |
| `document-summarizer` | Document summary generation |

## Configuration

app-dev-suite works out-of-the-box with sensible defaults defined in [conventions.md](conventions.md).

To customize defaults (docs directory, feature spec path, language), edit the Defaults table in `conventions.md` directly.

### Custom Investigation Tools

Register project-specific investigation tools (skills or agents) in the `## Custom Investigation Tools` table in `conventions.md`. Registered tools are automatically evaluated for relevance and invoked during investigation phases of deep-research, feasibility-study, and solution-design.

**Example:**

```markdown
| Name | Type | Description | Invocation |
|------|------|-------------|------------|
| Security Audit | skill | Analyze code for OWASP vulnerabilities | my-plugin:security-audit |
| Architecture Review | agent | Review against project architecture guidelines | .claude/agents/arch-review.md |
```

**Integration per skill:**
- **deep-research**: Custom tools become an assignable investigation method (`custom-tool`) during task decomposition
- **feasibility-study**: Relevant tools launch as additional parallel investigation agents
- **solution-design**: Relevant tools launch as additional parallel investigation agents alongside codebase-investigator

When the table is empty, all skills behave identically to the default (no custom tools).

## Project-Specific Plugins

app-dev-suite is designed to be generic. For project-specific skills (JIRA integration, architecture documentation, etc.), create a separate plugin:

```
my-project-skills/
├── .claude-plugin/
│   └── plugin.json
└── skills/
    ├── my-jira-integration/
    │   └── SKILL.md
    └── my-architecture-guide/
        └── SKILL.md
```

Install both plugins to combine generic workflow with project-specific capabilities.

## File Structure

```
app-dev-prompt-suite/                    # Marketplace repository
├── .claude-plugin/
│   └── marketplace.json                 # Marketplace catalog
└── plugins/
    └── app-dev-suite/                    # Plugin
        ├── .claude-plugin/
        │   └── plugin.json
        ├── skills/
        │   ├── deep-research/
        │   │   ├── SKILL.md
        │   │   ├── investigator-prompt.md
        │   │   ├── adaptation-prompt.md
        │   │   ├── task-result-format.md
        │   │   ├── report-format.md
        │   │   └── steps/
        │   ├── feasibility-study/
        │   │   ├── SKILL.md
        │   │   ├── report-format.md
        │   │   └── steps/
        │   ├── solution-design/
        │   │   ├── SKILL.md
        │   │   ├── design-format.md
        │   │   └── steps/
        │   ├── implement-tdd/
        │   │   ├── SKILL.md
        │   │   ├── scaling-strategies.md
        │   │   └── steps/
        │   ├── small-feature/
        │   │   └── SKILL.md
        │   └── generate-slides/
        │       ├── SKILL.md
        │       ├── slide-format.md
        │       └── steps/
        ├── script/
        │   └── convert-slides.sh
        ├── agents/
        │   ├── document-summarizer.md
        │   ├── poc-feasibility-expert.md
        │   ├── tdd-implementer.md
        │   └── web-research-expert.md
        ├── conventions.md
        ├── doc/
        │   └── workflow-diagrams.md
        └── README.md
```

## Example Workflow

```
# Optional: Deep Research
/app-dev-suite:deep-research "research topic"
# → Produces: {docs_dir}/{research_name}/research/research_report.md

# Phase 1: Feasibility Study (with or without prior research)
/app-dev-suite:feasibility-study
/app-dev-suite:feasibility-study -r {path-to-research_report.md}
# → Produces: {docs_dir}/{task_name}/feasibility/feasibility_report.md

# Phase 2: Solution Design
/app-dev-suite:solution-design
# → Produces: {docs_dir}/{task_name}/design/solution_design.md

# Phase 3: Implementation
/app-dev-suite:implement-tdd
# → Produces: {docs_dir}/{task_name}/implementation/implementation_report.md

# Generate presentation slides from artifacts
/app-dev-suite:generate-slides
# → Produces: {docs_dir}/{task_name}/slides_{task_name}.md
```
