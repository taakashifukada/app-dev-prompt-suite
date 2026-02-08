---
name: small-feature
description: Implement feature/bugfix/tech improvement with a TDD approach
argument-hint: [message]
allowed-tools: Read, Grep, Write, Edit
---

Implement the feature spec at `config.feature_spec.path` (default: `.claude/claudeRes/scripts/feature_spec.md`) using TDD.

## Steps

1. Read and understand the spec; investigate current implementation
2. AskUserQuestion to clarify ambiguities and finalize requirements
3. If spec demands something infeasible, propose alternatives
4. If web research needed: delegate to web-research-expert agent, review findings
5. Re-confirm requirements with user if new questions arose
6. Present implementation plan to user for approval
   - If user requests PoC: delegate to poc-feasibility-expert agent, show results
7. Finalize implementation items
8. Split into subtasks, present list for user approval
9. Map subtask dependencies (precedence diagram style)
10. Propose feature branch strategy; create or wait for user's branch
11. Checkout the feature branch
12. Save requirements + subtasks + precedence diagram to `{docs_dir}/{task_name}/solution_design.md`
    - Default docs_dir: `.claude/claudeRes/docs`
13. Present the document to user for review/approval
14. Incorporate user feedback into final plan
15. Submit the document to tdd-implementer agent; implement subtasks in dependency order via TDD
16. On completion: save implementation report to `{docs_dir}/{task_name}/dev_final.md`
    - Append PR Description: Background / Main Changes / Notes (3-10 lines each)

## Constraints

- DRY: reuse existing code
- If TDD is overkill: inform user, get approval, then use simpler approach
- For complex unknowns: delegate to poc-feasibility-expert agent
- Document language: `config.documents.language` (see [conventions](../../conventions.md))
