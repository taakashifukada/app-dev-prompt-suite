> Structural reference. Adapt headings to `config.documents.language`.

# Feasibility Report Format (max 100 lines)

```markdown
# Feasibility Report: {task-name}

**Created:** {date}
**Next step:** `/app-dev-suit:solution-design -s <this-file>`

## Requirements

{requirements summary — max 20 lines}

## Implementation Candidates

- Candidate 1: {summary}
- Candidate 2: {summary}
- Candidate 3: {summary}

## Chosen Approach

{final approach — max 20 lines}

## Rationale

{investigation results and selection reasoning — max 30 lines}

## Details

- [Codebase Analysis](./feasibility_details/codebase_analysis.md)
- [Alternatives Comparison](./feasibility_details/alternatives.md)
- [PoC Results](./poc/) *(if conducted)*
- [References](./references/) *(if web research conducted)*

## Quality Metrics

{metrics summary}

## Next Actions

1. Review this feasibility report
2. Run the following command to proceed:
   `/app-dev-suit:solution-design -s {actual-output-path}`
```
