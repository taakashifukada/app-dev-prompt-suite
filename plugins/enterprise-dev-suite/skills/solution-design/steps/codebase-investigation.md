# Deep Codebase Investigation

Launch codebase-investigator agent:
- investigation_type: design
- feature_spec_path: `.claude/claudeRes/scripts/feature_spec.md` (see conventions.md)
- target_files: {files identified in initial design (Step 5)}
- docs_dir, task_name

If Custom Investigation Tools are defined in conventions.md, launch relevant custom tools as additional parallel Task agents alongside the codebase-investigator:
- **skill** type: Use the Skill tool with the Invocation value, passing the design context as input
- **agent** type: Read the agent prompt file at the Invocation path, then launch a Task tool subagent (`subagent_type: general-purpose`, `model: sonnet`) with the agent prompt and the design context

Skip tools whose Description is clearly unrelated to the current design topic.

Receive synthesized investigation report. Merge codebase-investigator findings with any custom tool results. Use merged findings to inform subtask breakdown.
