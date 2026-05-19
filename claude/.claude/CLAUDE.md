# Global CLAUDE.md

## Comments

Comments must be one of two forms:

```
# descriptive but non-verbose comment
# KEYWORD:(@dqnk) descriptive but non-verbose comment
```

Rules:

- always lowercase
- no trailing punctuation
- keywords: WARN, FIXME, NOTE, TODO, PERF, TEST, HACK
- keyword comments must include attribution `(@dqnk)`

## Git

- commit only when asked or when delegating to agents
- agents MUST commit with `--no-gpg-sign`

## Workflow

- implement changes directly; don't use sub-agents/Task for simple operations like renames, file moves, or single-file edits; only use Task for genuinely complex parallel exploration or research
- when redirected or interrupted, immediately stop the current approach and follow the new direction; don't explain or defend the previous approach
- focus on one goal per session; don't drift into unrelated improvements
- use Task agents for research and exploration, not for straightforward implementation

## Scope

- NEVER modify anything outside the scope of what was asked
- don't introduce unrelated changes, touch unrelated configs, or change defaults not mentioned
- if something related should change, ask first

## Config locations

- MCP server configs go in `.claude.json` (project) or `$HOME/.claude.json` (global, defaults to `~/.claude.json`), not `settings.json`
- `settings.json` is for permissions, hooks, and behavior settings

## Code quality

- after making changes, check if the project has linters/formatters and run them
