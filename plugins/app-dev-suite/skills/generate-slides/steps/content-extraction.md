# Content Extraction

Extract content from phase artifacts for slide generation.

## Procedure

For each selected phase:

1. **Read summary document** — the primary report file for the phase
2. **Read detail documents** — referenced in [slide-format.md](../slide-format.md) per slide

## Per-Slide Extraction

For each slide defined in slide-format.md:
- Locate the source file and target section
- Extract content within that section
- If content exceeds 12 lines: delegate to `document-summarizer` agent with 12 as the max line count

## Special Content Handling

### Mermaid Code Blocks
Preserve verbatim. Never summarize or modify Mermaid blocks.

### Tables
Preserve table structure. If table exceeds 8 rows: keep header + top 6 data rows + "... ({N} more rows)" footer row.

### Bullet Lists
If list exceeds 12 lines: delegate to `document-summarizer` agent to condense.

## Phase-to-Artifact Mapping

| Phase | Document |
|-------|----------|
| feasibility | `feasibility/feasibility_report.md` |
| design | `design/solution_design.md` |
| implementation | `implementation/implementation_report.md` |
