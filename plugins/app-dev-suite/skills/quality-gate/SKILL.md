---
name: quality-gate
description: Metrics tracking definitions and report output specification for the app-dev-suite workflow.
user-invocable: false
---

# Quality Metrics Tracking

Metrics tracking definitions used by phase skills during workflow execution.
Quality gate evaluation is performed by the `quality-gate-evaluator` agent at phase boundaries.

## Metrics Tracker

Initialize at start of a task, update during each phase, save at completion.

**Structure**:
```
task_name, created timestamp
phases:
  feasibility_study: files_analyzed, web_research_count, solution_candidates, poc_count, issues_found
  solution_design: subtask_count, test_case_count, dependency_depth, review_rounds, issues_found
  implementation: files_changed, tests_added, test_coverage, design_issues
```

Track metrics incrementally during each phase. Record start/completion timestamps per phase.

## Evidence-Based Metrics

Metrics must include verifiable evidence. Metrics without evidence → automatically Warn.
If test runner is unavailable → record "manual review" and escalate to user.

| Metric | Evidence Required |
|--------|-------------------|
| files_analyzed | List actual file paths in checklist |
| test_coverage | Run test coverage command, capture output |
| tests_passing | Run test command, capture exit code and summary |
| files_changed | Run `git diff --stat`, capture output |
| tests_added | List new test file paths and test function names |
| web_research_count | List URLs consulted |
| solution_candidates | List candidate names from report |

## Metrics Report

Save to `{docs_dir}/{task_name}/quality_metrics.md` with:
- Overall timeline (start, end, duration)
- Per-phase metrics with actual values
- Quality indicators (issue resolution rate, avg subtask size, test coverage)
