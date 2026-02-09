# Phase 1 — Requirements & Research

1. Analyze the spec.
2. Clarify ambiguities with the user.
3. Explore the codebase thoroughly by launching **up to 3 Explore subagents IN PARALLEL** (single message, multiple Task tool calls). Assign each agent a distinct search focus. Examples:
   - Agent A: Existing implementations and modules related to the spec
   - Agent B: Architecture patterns, conventions, and dependencies
   - Agent C: Existing test structure and related test utilities
   - If web research is needed -> Agent D: launch `web-research-expert` subagent with the requirements
4. Review all reports from the parallel agents and synthesize findings.
5. Re-clarify the requirement with the user if new questions arise here.
