# app-dev-suite Conventions

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

## Document Update Confirmation

When updating existing documents, present diff format for user approval before writing:

```
=== Document Update Confirmation ===

File: {document_file_path}

Changes Summary:
- {change 1}
- {change 2}

--- Before ---
{existing content being changed}

--- After ---
{updated content}

=== End of Update Preview ===
```

Only update after user approval.

## Phase Progress Tracking

On skill completion: save `{docs_dir}/{task_name}/progress.yaml` with task_name, current_phase, and per-phase status/output/completed_at.

On skill startup: if `progress.yaml` exists in output_dir, AskUserQuestion — resume / start fresh / Type Anything.

## Issue Handling

When discovering issues during any phase:
1. Add `## Issues Found During {Phase}` section to current document
2. AskUserQuestion: fix / continue / rollback
3. Record decision and rationale
