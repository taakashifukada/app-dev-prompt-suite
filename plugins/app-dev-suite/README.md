# app-dev-suite

A Claude Code plugin providing a three-phase spec-driven development workflow: feasibility study, solution design, and TDD implementation.

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
/app-dev-suite:feasibility-study
/app-dev-suite:solution-design
/app-dev-suite:implement-tdd
/app-dev-suite:setup-wizard
/app-dev-suite:small-feature
```

## Overview

app-dev-suite is a structured development workflow plugin for teams that need **process transparency**, **decision traceability**, and **quality gates** — capabilities that Claude Code's built-in Plan Mode does not provide.

### Three-Phase Workflow

1. **Feasibility Study** — Codebase analysis, web research, solution candidates, and optional PoC
2. **Solution Design** — Subtask breakdown, dependency mapping, test case planning
3. **TDD Implementation** — Test-driven development with per-subtask quality checks

Each phase produces structured documents (summary + hierarchical details) that serve as audit trails and team-shareable artifacts.

### Why app-dev-suite over Plan Mode?

| | Plan Mode | app-dev-suite |
|---|---|---|
| **ワークフロー** | ユーザが都度設計 | 3フェーズ+品質ゲートが事前構築済み |
| **成果物の永続性** | 会話内で完結しがち | フェーズごとにファイル生成、セッション跨ぎで再開可能 |
| **意思決定記録** | 明示的に指示しない限り残らない | alternatives.mdへの記録がワークフローに組み込み済み |
| **品質チェック** | なし | フェーズ境界でエビデンス付き品質ゲート |
| **出力の一貫性** | 実行ごとに異なる | テンプレートで構造を統一、多言語対応 |
| **専門エージェント** | 汎用サブエージェントのみ | TDD/PoC/調査/要約の4専門エージェント |

**Best fit**: Projects requiring explainability — why this design was chosen, what alternatives were considered, and what quality criteria were met. Ideal when development decisions need to be reviewed by team members or stakeholders.

For quick individual tasks, Plan Mode or `/app-dev-suite:small-feature` remains the simpler choice.

## Quick Start

### First-Time Setup

Run the interactive setup wizard:
```
/app-dev-suite:setup-wizard
```

Generates a customized `.claude/config.yaml` in your project.

### Basic Usage (No Configuration Required)

```
/app-dev-suite:feasibility-study    # Phase 1
/app-dev-suite:solution-design      # Phase 2
/app-dev-suite:implement-tdd        # Phase 3
```

### Quick Implementation

For smaller tasks that don't need the full three-phase workflow:
```
/app-dev-suite:small-feature
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

app-dev-suite works out-of-the-box with sensible defaults. For customization:
- Run `/app-dev-suite:setup-wizard`
- Or edit `.claude/config.yaml` directly

See `config.default.yaml` for the complete schema.

### Config Loading

1. Read `.claude/config.yaml` (user config in project, if exists)
2. Read plugin's `config.default.yaml` (bundled defaults)
3. Deep merge: user config overrides defaults

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
        │   ├── feasibility-study/
        │   │   ├── SKILL.md
        │   │   ├── report-format.md
        │   │   ├── details-format.md
        │   │   └── steps/
        │   ├── solution-design/
        │   │   ├── SKILL.md
        │   │   ├── design-format.md
        │   │   ├── details-format.md
        │   │   ├── subtask-design-template.md
        │   │   └── steps/
        │   ├── implement-tdd/
        │   │   ├── SKILL.md
        │   │   ├── scaling-strategies.md
        │   │   └── steps/
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
/app-dev-suite:feasibility-study
# → Produces: {docs_dir}/{task_name}/feasibility_report.md

# Phase 2: Solution Design
/app-dev-suite:solution-design
# → Produces: {docs_dir}/{task_name}/solution_design.md

# Phase 3: Implementation
/app-dev-suite:implement-tdd
# → Produces: {docs_dir}/{task_name}/implementation_report.md
```
