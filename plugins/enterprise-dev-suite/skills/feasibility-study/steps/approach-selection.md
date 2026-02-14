# Approach Selection

AskUserQuestion: select approach / request PoC / request additional investigation

## PoC Path

1. AskUserQuestion: which candidates to test
2. For each candidate: delegate to poc-feasibility-expert agent with:
   - Hypothesis
   - Scope boundaries
   - Success criteria
3. Save PoC to `{docs_dir}/{task_name}/feasibility/`
4. Return to approach selection

## Additional Investigation Path

1. AskUserQuestion for investigation focus
2. Run appropriate agents (Explore / web-research-expert / Read+Grep)
3. Save references to `{docs_dir}/{task_name}/feasibility/`
4. Return to approach selection
