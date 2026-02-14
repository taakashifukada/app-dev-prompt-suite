# enterprise-dev-suite Conventions

## Defaults

| Setting | Value |
|---|---|
| docs_dir | `.claude/claudeRes/docs`(`.claude` is project-level one.) |
| feature_spec_path | `.claude/claudeRes/scripts/feature_spec.md`(`.claude` is project-level one.)  |
| language | `"auto"` — detect from feature spec. If undetectable, use user message language. |

To customize: edit this table directly.

## Document Language

Generate all documents in the language specified above.
- `"auto"`: detect from the feature spec at `feature_spec_path`. If undetectable, use the language of user messages.
- Specific code (e.g. `"ja"`, `"en"`): use that language.

Template files serve as structural references. Adapt headings and content to the document language.

## Custom Investigation Tools

Tools listed here are automatically available during investigation phases of all skills.
Each tool is evaluated for relevance to the current research topic and used when judged appropriate.

| Name | Type | Description | Invocation |
|------|------|-------------|------------|

- **Type**: `skill` — Claude Code plugin skill / `agent` — agent prompt file (.md)
- **Invocation**: skill → skill name (e.g. `my-plugin:security-audit`) / agent → path to .md file relative to project root

## Issue Handling

When discovering issues during any phase:
1. Add `## Issues Found During {Phase}` section to current document
2. AskUserQuestion: fix / continue / rollback
3. Record decision and rationale
