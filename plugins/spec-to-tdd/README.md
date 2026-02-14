# spec-to-tdd

A Claude Code plugin providing a unified single-skill workflow from feature spec to TDD implementation — with structured design documents, user approval gates, and easy-to-review branching.

## Installation

### Via Marketplace (Recommended)

```bash
claude plugin add taakashifukada/app-dev-prompt-suite/plugins/spec-to-tdd
```

### From Local Directory

```bash
claude --plugin-dir ./spec-to-tdd-plugin
```

## Overview

spec-to-tdd is a **single-skill, 4-phase workflow** that takes a feature spec and produces tested, branch-ready code with a full design trail. One command drives the entire flow — the skill orchestrates exploration, design, documentation, and TDD implementation internally.

### Workflow

```
/spec-to-tdd:spec-to-tdd
    │
    ├─ Phase 1: Requirements & Research
    │   └─ Parallel codebase exploration + web research
    ├─ Phase 2: Solution Design
    │   └─ Implementation approach + subtask breakdown with user approval
    ├─ Phase 3: Design Document
    │   └─ Persisted solution design document for review
    └─ Phase 4: TDD Implementation
        └─ Feature branch + TDD per subtask + final report with PR description
```

| Phase | What happens | User approval |
|-------|-------------|---------------|
| **1. Requirements & Research** | Spec analysis, parallel codebase exploration (up to 3 agents), optional web research | Clarification Q&A |
| **2. Solution Design** | Implementation approach, optional PoC, subtask breakdown with precedence diagram | Approach + subtask approval |
| **3. Design Document** | Structured design document saved to project | Document review |
| **4. TDD Implementation** | Feature branch, TDD per subtask in dependency order, final report with PR description | Branch name + completion review |

### Design Philosophy

- **Single entry point**: One skill handles the entire spec-to-code pipeline
- **Document-driven**: Every phase builds on persisted artifacts, not ephemeral conversation
- **Branch-ready output**: Feature branch + PR description included in the final report
- **User control**: Approval gates at every phase transition prevent runaway implementation

## Quick Start

1. Write a feature spec at `<project-root>/.claude/claudeRes/scripts/feature_spec.md`
2. Run:
   ```
   /spec-to-tdd:spec-to-tdd
   ```
3. Follow the interactive prompts through each phase.

## Skill

| Skill | Description |
|-------|-------------|
| `spec-to-tdd` | Unified 4-phase workflow: requirements → design → document → TDD implementation |

## Agents

| Agent | Purpose |
|-------|---------|
| `web-research-expert` | Technical research and documentation lookup |
| `poc-feasibility-expert` | PoC implementation and validation for uncertain approaches |
| `tdd-implementer` | TDD-based implementation per subtask |
| `document-summarizer` | Document summary generation |

## Artifacts

| Output | Path |
|--------|------|
| Solution design document | `.claude/claudeRes/docs/<YY_MM_DD>_solution_design_<name>.md` |
| Final report (with PR description) | `.claude/claudeRes/docs/<YY_MM_DD>_dev_final_<name>.md` |

## spec-to-tdd vs app-dev-suite

| | spec-to-tdd | app-dev-suite |
|---|---|---|
| **Entry point** | Single skill (`/spec-to-tdd:spec-to-tdd`) | Multiple skills per phase (`/feasibility-study`, `/solution-design`, `/implement-tdd`) |
| **Workflow** | Unified 4-phase, one invocation | Modular — run phases independently |
| **Phases** | Requirements → Design → Document → TDD | Deep Research → Feasibility → Design → TDD |
| **Artifacts** | Design doc + final report | Report per phase (feasibility, design, implementation) |
| **Deep research** | Web research integrated into Phase 1 | Standalone `/deep-research` skill with adaptive re-evaluation |
| **Custom investigation tools** | Not supported | Configurable via `conventions.md` |
| **Best fit** | Solo developers wanting a streamlined spec-to-code pipeline | Teams needing per-phase review, traceability, and configuration |

## File Structure

```
spec-to-tdd/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   └── spec-to-tdd/
│       ├── SKILL.md
│       └── steps/
│           ├── phase1-requirements.md
│           ├── phase2-solution-design.md
│           ├── phase3-design-document.md
│           ├── phase4-tdd-implementation.md
│           └── solution-design-template.md
├── agents/
│   ├── web-research-expert.md
│   ├── poc-feasibility-expert.md
│   ├── tdd-implementer.md
│   └── document-summarizer.md
└── README.md
```

## License

MIT
