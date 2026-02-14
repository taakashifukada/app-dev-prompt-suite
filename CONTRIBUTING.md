# Contributing to enterprise-dev-suite

## How to Contribute

### Bug Reports & Feature Requests

Open an [Issue](https://github.com/arudita-zzz/enterprise-dev-suite/issues) with:
- Clear description of the problem or idea
- Steps to reproduce (for bugs)
- Expected vs actual behavior

### Pull Requests

1. Fork the repository
2. Create a feature branch from `main`
3. Make your changes
4. Test with Claude Code locally: `claude --plugin-dir ./plugins/enterprise-dev-suite`
5. Submit a PR with a clear description of the changes

### What to Contribute

- Bug fixes in skills or agents
- Prompt improvements (with before/after examples)
- New language support in `conventions.md`
- Documentation improvements

## Project Structure

```
plugins/enterprise-dev-suite/
├── skills/           # User-invocable skills (SKILL.md + steps/)
├── agents/           # Subagent definitions (.md)
├── script/           # Shell scripts
├── conventions.md    # Configurable defaults
└── README.md
```

### Skills

Each skill lives in `skills/{name}/` with:
- `SKILL.md` — Entry point and skill metadata
- `steps/` — Step-by-step execution prompts
- Supporting format files (e.g., `report-format.md`)

### Agents

Agent definitions are single `.md` files in `agents/`.

## Guidelines

- **Prompts are for AI**: No human-facing comments or modifiers within prompt files
- **Scripts go in `/script`**: Separate shell/python scripts from prompt files
- **Test locally** before submitting: Run the skill end-to-end with Claude Code
- **Keep prompts concise**: Minimal words, maximum clarity

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
