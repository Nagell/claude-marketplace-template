# base-plugin

The base plugin for your marketplace. It ships one real, ready-to-use skill
(`skill-creator`), plus a sample hook that shows the structure and is meant to be
replaced.

```text
base-plugin/
├── .claude-plugin/
│   └── plugin.json          # plugin metadata (the only required file)
├── hooks/
│   ├── hooks.json           # SAMPLE hook wiring (replace or delete)
│   └── example-guard.sh     # SAMPLE no-op PreToolUse hook (replace or delete)
└── skills/
    └── skill-creator/       # real skill - scaffolds new skills (Anthropic, Apache-2.0)
```

## What's real vs. what's a sample

- **`skill-creator`** - keep it. It's a working tool that helps you author new
  skills the right way. Once the plugin is installed, Claude reaches for it on
  its own when you ask it to "create a skill", or you can invoke it directly.
  It's Anthropic's, under the Apache License 2.0 (see its `LICENSE.txt`); the
  rest of this template is public domain.
- **Hook (`hooks.json` + `example-guard.sh`)** - a no-op `PreToolUse` hook that
  allows everything. Add real rules or delete the `hooks/` directory and the
  `hooks` wiring.

A plugin only needs `.claude-plugin/plugin.json` to exist. Keep the parts you
use and delete the rest.

## Make it yours

1. Set `author` (and optionally `name`, `description`, `keywords`) in
   `.claude-plugin/plugin.json`.
2. Replace or remove the sample hook.
3. Use the `skill-creator` skill to build your own skills.

`marketplace.json`, the Release Please config and version bumps are all handled
by CI - you never edit them by hand.
