# app-dev-suit

A Claude Code plugin providing a three-phase spec-driven development workflow: feasibility study, solution design, and TDD implementation.

## Installation

### Via Marketplace (Recommended)

```bash
# Add marketplace
/plugin marketplace add "Takashi Fukada/app-dev-suite"

# Install plugin
/plugin install app-dev-suit@app-dev-suite
```

### From Local Directory

```bash
claude --plugin-dir ./app-dev-suit-plugin
```

After installation, skills are accessible with the `app-dev-suit:` namespace prefix:
```
/app-dev-suit:feasibility-study
/app-dev-suit:solution-design
/app-dev-suit:implement-tdd
/app-dev-suit:setup-wizard
/app-dev-suit:small-feature
```

## Overview

app-dev-suit provides a three-phase development workflow:

1. **Feasibility Study** — Deep analysis of requirements, codebase research, and solution exploration
2. **Solution Design** — Detailed implementation planning with test cases and task breakdown
3. **TDD Implementation** — Test-driven development following the solution design

## Quick Start

### First-Time Setup

Run the interactive setup wizard:
```
/app-dev-suit:setup-wizard
```

Generates a customized `.claude/config.yaml` in your project.

### Basic Usage (No Configuration Required)

```
/app-dev-suit:feasibility-study    # Phase 1
/app-dev-suit:solution-design      # Phase 2
/app-dev-suit:implement-tdd        # Phase 3
```

### Quick Implementation

For smaller tasks that don't need the full three-phase workflow:
```
/app-dev-suit:small-feature
```

## Skills

| Skill | Description |
|-------|-------------|
| `feasibility-study` | Codebase analysis, web research, solution candidates, PoC |
| `solution-design` | Subtask breakdown, test cases, precedence diagram |
| `implement-tdd` | TDD implementation per subtask with quality gates |
| `setup-wizard` | Interactive configuration wizard |
| `small-feature` | All-in-one quick implementation with TDD |
| `quality-gate` | (Background) Checklists, metrics, gate decisions |

## Agents

| Agent | Purpose |
|-------|---------|
| `poc-feasibility-expert` | PoC implementation and validation |
| `tdd-implementer` | TDD-based implementation |
| `web-research-expert` | Technical research and documentation |
| `document-summarizer` | Document summary generation |

## Configuration

app-dev-suit works out-of-the-box with sensible defaults. For customization:
- Run `/app-dev-suit:setup-wizard`
- Or edit `.claude/config.yaml` directly

See `config.default.yaml` for the complete schema.

### Config Loading

1. Read `.claude/config.yaml` (user config in project, if exists)
2. Read plugin's `config.default.yaml` (bundled defaults)
3. Deep merge: user config overrides defaults

## Project-Specific Plugins

app-dev-suit is designed to be generic. For project-specific skills (JIRA integration, architecture documentation, etc.), create a separate plugin:

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
app-dev-suit/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── skills/
│   ├── feasibility-study/
│   │   ├── SKILL.md
│   │   ├── report-format.md
│   │   └── details-format.md
│   ├── solution-design/
│   │   ├── SKILL.md
│   │   ├── design-format.md
│   │   ├── details-format.md
│   │   └── subtask-design-template.md
│   ├── implement-tdd/
│   │   ├── SKILL.md
│   │   └── scaling-strategies.md
│   ├── quality-gate/
│   │   ├── SKILL.md
│   │   └── quality-checklist-template.md
│   ├── setup-wizard/
│   │   ├── SKILL.md
│   │   └── config-template.md
│   └── small-feature/
│       └── SKILL.md
├── agents/
│   ├── document-summarizer.md
│   ├── poc-feasibility-expert.md
│   ├── tdd-implementer.md
│   └── web-research-expert.md
├── conventions.md
├── config.default.yaml
├── doc/
│   └── workflow-diagrams.md
└── README.md
```

## Example Workflow

```
# Phase 1: Feasibility Study
/app-dev-suit:feasibility-study
# → Produces: {docs_dir}/{task_name}/feasibility_report.md

# Phase 2: Solution Design
/app-dev-suit:solution-design
# → Produces: {docs_dir}/{task_name}/solution_design.md

# Phase 3: Implementation
/app-dev-suit:implement-tdd
# → Produces: {docs_dir}/{task_name}/implementation_report.md
```
