# Speaker Script: Automating Dev Workflow and Letting AI Do It

**Duration:** ~15 minutes
**Format:** Knowledge sharing meeting
**Language:** English

---

## Slide 1: Title (0:00 - 0:30)

Hi everyone, thanks for joining. Today I want to share what I've been working on with Claude Code — specifically, an attempt to automate more of the development workflow so that AI doesn't just help you write code, but actually drives a structured process with minimal hand-holding.

The title is "Automating Dev Workflow and Letting AI Do It" — and I'll walk through what we built, what worked, what didn't, and the lessons learned.

---

## Slide 2: The Problem (0:30 - 2:00)

So let's start with the problem.

When you use Claude Code today, the typical interaction is: you describe what you want, AI makes a plan, and then it writes the code. If you're using Plan Mode, it'll think through the approach before implementing. And honestly, Plan Mode is pretty good at producing working code.

But there are a few issues from a team development perspective.

First, **the process is a black box**. The plan lives inside the conversation. If you're a reviewer, you don't see the reasoning — you just see the final diff.

Second, **there's no document generation**. No feasibility analysis, no design document, no record of what alternatives were considered and why one was chosen over another.

Third, **it typically produces a single commit on a single branch**. All the implementation lands at once. For reviewers, that can be hard to digest, especially for larger features.

So the goal was: can we build something where AI follows a structured, multi-phase process — and produces reviewable artifacts at each stage?

---

## Slide 3: What We Built (2:00 - 3:30)

What we built is the **app-dev-suite plugin** for Claude Code.

It's a three-phase workflow:
- **Phase 1: Feasibility Study** — analyze the codebase, research best practices, evaluate approach candidates, and select one.
- **Phase 2: Solution Design** — break the solution into subtasks, map dependencies, define test cases.
- **Phase 3: TDD Implementation** — implement each subtask using Test-Driven Development, one branch per subtask.

The key idea is that each phase produces a **structured document**. These documents serve as checkpoints. You can review the feasibility report before any design work starts. You can review the design before any code is written. And during implementation, each subtask has its own branch and commit history.

The phases are connected by their documents — the feasibility report feeds into solution design, and the solution design feeds into implementation.

---

## Slide 4: Architecture — Skills & Agents (3:30 - 5:00)

Let me walk through the architecture.

There are two layers: **Skills** and **Agents**.

**Skills** are the user-facing commands — you invoke them with slash commands like `/feasibility-study` or `/implement-tdd`. Skills act as **orchestrators**. They manage the overall flow, coordinate agents, handle user interactions, and produce documents.

**Agents** are the specialized workers. Each one has a focused role:
- **codebase-investigator** — does deep, iterative exploration of the codebase using a three-phase approach
- **web-research-expert** — searches for official documentation and best practices
- **poc-feasibility-expert** — runs proof-of-concept experiments when there's technical uncertainty
- **tdd-implementer** — implements code following strict TDD: Red, Green, Refactor
- **document-summarizer** — condenses long documents into concise summaries
- **quality-gate-evaluator** — independently assesses the quality of phase deliverables

The orchestrator pattern is important here — the skill designs and delegates, but never implements code directly.

---

## Slide 5: Parallel Investigation (5:00 - 6:30)

One of the most effective design choices was **parallel investigation**.

In Phase 1, the feasibility study skill launches multiple agents concurrently. The codebase-investigator internally spawns three parallel Explore agents, each with a different focus:
- One looks for **similar implementations** — existing patterns we can reuse
- One looks for **test patterns** — how tests are structured in this project
- One maps **impact scope** — what files would be affected, what are the dependencies

At the same time, the web-research-expert is running concurrently, gathering best practices and documentation from official sources.

All of these results get merged into a unified analysis. This is significantly faster than doing sequential investigation, and it's also more context-efficient because each agent has a narrow, focused scope rather than trying to hold everything in one context window.

---

## Slide 6: Subtask-Based Branching (6:30 - 7:30)

In Phase 3, implementation follows a **subtask-based branching** strategy.

Instead of writing all the code on a single branch, the tdd-implementer creates a separate branch for each subtask. On each branch, it follows the TDD cycle — write a failing test, make it pass, refactor. Then it commits and requests user approval before merging back to the feature branch.

This means reviewers can look at each subtask independently. The commits are small and focused. And if something goes wrong with one subtask, you can catch it before it contaminates the rest of the implementation.

---

## Slide 7: Document Checkpoints (7:30 - 8:30)

The document checkpoint system is really the core value proposition.

Phase 1 produces a feasibility report with details on codebase analysis and alternatives considered. Phase 2 produces a solution design with subtask breakdown, dependency diagrams, and test cases. Phase 3 produces an implementation report with a PR description.

The benefits are:
- **Early course correction** — if the feasibility analysis picks a bad approach, you catch it before any code is written
- **Team visibility** — anyone on the team can read these documents, not just whoever ran the AI session
- **Audit trail** — six months later, you can go back and understand why a particular design was chosen

---

## Slide 8: Results — What Worked (8:30 - 9:30)

So what worked?

The document generation and subtask-based branching definitely made review easier. Each step is independently reviewable. The feasibility report catches questionable approaches early. The Mermaid dependency diagrams in the design document make it visual and easy to understand.

The parallel investigation was also a clear win. Having multiple agents explore different aspects of the codebase simultaneously is both faster and more thorough than doing it sequentially.

---

## Slide 9: Results — What Didn't Work (9:30 - 11:00)

But there were real downsides.

**Execution time increased significantly**. Plan Mode is fast — it does a single pass. Our workflow goes through three phases, each with document generation, user approval gates, and quality checks. The tradeability gain comes at the cost of speed.

More importantly, **AI accuracy degrades with task scope**. When subtasks were small and well-defined, the implementation was generally correct. But when the scope was larger or more complex, the error rate climbed noticeably. The more you ask AI to do at once, the more likely it is to make mistakes.

This was actually one of the most important findings — it directly influenced how we think about scoping AI work.

---

## Slide 10: Learnings — Part 1 (11:00 - 12:30)

Let me share four key learnings.

**First: parallel subagents are highly effective for investigation tasks.** Launching multiple agents to explore different concerns concurrently is both faster and better for context management. Each agent has a focused scope, so it doesn't get overwhelmed. The built-in Explore agent in Claude Code is a great building block for this pattern. If you're writing custom skills or agents, consider using parallel investigation.

**Second: AI output verification is essential.** This might sound obvious, but it's easy to get complacent. AI still makes mistakes, especially at scale. Having quality gates and document checkpoints isn't a nice-to-have — it's a necessity. The structured workflow forces you to stop and review before proceeding, which catches issues early.

---

## Slide 11: Learnings — Part 2 (12:30 - 14:00)

**Third — and this is the bitter lesson — less is more.** Over 50% of the original prompts in this plugin were removed in the final version. We started with very detailed, comprehensive prompts trying to cover every edge case. What happened? The AI got confused. It would drift from the intent, or produce inconsistent output.

Simpler, more focused prompts turned out to be more reliable. Don't try to make AI do too much in one go. Keep the instructions clear and the scope narrow. This is probably the most counterintuitive lesson — you'd think more detailed instructions would produce better results, but past a certain point, it's counterproductive.

**Fourth: clone your repo twice.** This is a practical tip. Keep one clone for yourself and one for AI. Run AI on one clone while you review or do other work on the other. When the AI finishes, merge the results. This effectively doubles your productivity because you're not sitting idle while AI works, and you're not blocking AI while you review.

---

## Slide 12: Summary (14:00 - 14:30)

To summarize: Plan Mode is fast and works well for quick, solo tasks. The app-dev-suite plugin trades speed for traceability, reviewability, and error detection at each checkpoint. It's best suited for team projects and larger features where multiple people need to understand what happened and why.

The key takeaway is: structuring AI's work into phases with document checkpoints makes the output reviewable and correctable — at the cost of execution time.

---

## Slide 13: Questions (14:30 - 15:00)

That's it from me. The plugin is available in the repo — the latest implementation is on the `poc/lightening` branch. Feel free to try it out and let me know if you have questions.

---

## Timing Summary

| Slide | Topic | Cumulative |
|-------|-------|------------|
| 1 | Title | 0:30 |
| 2 | Problem | 2:00 |
| 3 | What We Built | 3:30 |
| 4 | Architecture | 5:00 |
| 5 | Parallel Investigation | 6:30 |
| 6 | Subtask Branching | 7:30 |
| 7 | Document Checkpoints | 8:30 |
| 8 | What Worked | 9:30 |
| 9 | What Didn't Work | 11:00 |
| 10 | Learnings Part 1 | 12:30 |
| 11 | Learnings Part 2 | 14:00 |
| 12 | Summary | 14:30 |
| 13 | Questions | 15:00 |
