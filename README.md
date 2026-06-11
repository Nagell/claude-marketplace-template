<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->

[![Unlicense][license-shield]][license-url]

<!-- PROJECT TITLE -->
<br />
<div align="center">
  <a href="https://github.com/Nagell/claude-marketplace">
    <img src="assets/logo.svg" alt="Logo" width="80" height="80">
  </a>
  <h3 align="center">Claude Marketplace Template</h3>

  <p align="center">
    A starter for your own Claude Code marketplace - one example plugin, automated versioning, and release CI wired up from the first push.
    <br />
    <br />
    <a href="#getting-started"><strong>Get started »</strong></a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#use-this-template">Use this template</a></li>
        <li><a href="#placeholders-to-change">Placeholders to change</a></li>
        <li><a href="#enable-the-release-pipeline">Enable the release pipeline</a></li>
        <li><a href="#your-first-release">Your first release</a></li>
      </ul>
    </li>
    <li><a href="#plugins">Plugins</a></li>
    <li>
      <a href="#versioning--releases">Versioning &amp; Releases</a>
      <ul>
        <li><a href="#how-it-works">How it works</a></li>
        <li><a href="#commit-message-format">Commit message format</a></li>
        <li><a href="#files-updated-automatically">Files updated automatically</a></li>
      </ul>
    </li>
    <li><a href="#directory-structure">Directory Structure</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

A starter for building your own Claude Code marketplace - a public GitHub repo that holds your plugins and lets anyone install them with two commands.

It ships one `base-plugin` that already carries a working `skill-creator` skill, so you can scaffold new skills the moment you start. Alongside that it sets up the part that's annoying to wire by hand: versioning and releases driven entirely by your commit messages. Add a plugin, push a `feat:` or `fix:` commit, and the rest is automated.

This is a GitHub template, not a fork. Hit **Use this template**, swap the placeholders, and start adding plugins.

### Built With

[![Claude Code][Claude]][Claude-url] [![Bash][Bash]][Bash-url] [![GitHub Actions][GitHubActions]][GitHubActions-url] [![Conventional Commits][ConventionalCommits]][ConventionalCommits-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

### 1. Use this template

1. Click **Use this template → Create a new repository** at the top of this repo on GitHub.
2. Clone your new repo and open it.
3. Work through the placeholders below, then start adding plugins.

Once it's pushed and public, anyone (including you, on any machine) installs your plugins with:

```sh
/plugin marketplace add CHANGE_ME_USERNAME/CHANGE_ME_REPO
/plugin install base-plugin@my-marketplace
```

`base-plugin@my-marketplace` is `<plugin-name>@<marketplace-name>` - the marketplace name comes from the `name` field in `.claude-plugin/marketplace.json`.

### 2. Placeholders to change

Search the repo for `CHANGE_ME` and replace each one. Here's where they live:

| File | Field | What to set it to |
| --- | --- | --- |
| `.claude-plugin/marketplace.json` | `name` | Your marketplace name (used in the install command). Currently `my-marketplace`. |
| `.claude-plugin/marketplace.json` | `owner.name`, `author.name`, `author.email` | You. |
| `plugins/base-plugin/.claude-plugin/plugin.json` | `author.name`, `author.email` | Set the author. Keep the `base-plugin` name or rename it. |
| `CLAUDE.md` | `plugin.json` template author | Your name and email. |
| `README.md` | install commands, Contact, the template-credit link | Your repo URL, marketplace name and contact. |

> [!Important]
> If you rename `plugins/base-plugin/`, also rename its entry in `marketplace.json` and `.release-please-manifest.json`. (CI keeps them in sync after the first push, but fixing them up front avoids a stray entry.)

### 3. Enable the release pipeline

The workflow needs write access to push the sync commit and open Release PRs. No token to create - it uses the built-in `GITHUB_TOKEN`. Under **Settings → Actions → General**:

1. Switch the radio button in **Actions permissions** to **"Allow all actions and reusable workflows"**.
2. Switch the radio button in **Workflow permissions** to **"Read repository contents and packages permissions"**.
3. Tick **"Allow GitHub Actions to create and approve pull requests"** below, then **Save**.

Skip step 2 or 3 and the run fails with a `403`.

> [!Note]
> **You can leave `main` unprotected** - simplest, since the pipeline pushes to `main` itself. Basic protection (restrict deletions, block force pushes) is fine too; neither blocks a normal commit. Only stricter rules - require a PR, restrict updates, signed commits or linear history - block the bot's sync push, and a personal repo can't easily exempt it. Keep those off `main`.

### 4. Your first release

A feature branch isn't required - Release Please triggers on any commit reaching `main` - but see the recommendation below.

1. Commit a change with a conventional prefix, e.g. `feat: add my first plugin`, and get it onto `main`.
2. The workflow syncs `marketplace.json`, then opens a separate **Release PR** (the bot's, not yours).
3. Merge that PR. It publishes a tagged GitHub Release, bumps the version, and writes the changelog.

**Recommended: work on `dev`, PR into `main`.**  
The workflow auto-commits to `main`, so a working `dev` branch saves you constantly pulling those bot commits. Two merge gotchas:

- If using **squash-merge** the title is what Release Please reads, so keep the conventional prefix or no version bump happens.
- It tracks its Release PR by the `autorelease: pending` label, not the title. If the next Release PR never opens, a stale `autorelease: pending` label left on an old PR is the usual cause - remove it and re-run.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PLUGINS -->

## Plugins

| Plugin                              | Description                                                          |
| ----------------------------------- | -------------------------------------------------------------------- |
| [base-plugin](plugins/base-plugin/) | Ships the `skill-creator` skill, plus a sample hook |

Add your own plugins as rows here as you build them.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- VERSIONING & RELEASES -->

## Versioning & Releases

This repository uses [Release Please](https://github.com/googleapis/release-please) for automated versioning based on [Conventional Commits](https://www.conventionalcommits.org/).

### How it works

1. When you merge a PR to `main`, Release Please analyzes commit messages
2. It creates a Release PR with version bumps and changelog updates
3. Merging the Release PR publishes the new version

Each plugin versions independently. A small CI script (`scripts/generate-release-config.js`) discovers plugins under `plugins/` and keeps `marketplace.json` and the Release Please config in sync from each `plugin.json` on every push.

### Commit message format

| Prefix                         | Version Bump          | Example                       |
| ------------------------------ | --------------------- | ----------------------------- |
| `feat:`                        | Minor (0.1.0 → 0.2.0) | `feat: add new safety hook`   |
| `fix:`                         | Patch (0.1.0 → 0.1.1) | `fix: correct regex in guard` |
| `feat!:` or `BREAKING CHANGE:` | Major (0.1.0 → 1.0.0) | `feat!: redesign hook API`    |

### Files updated automatically

- `plugins/<name>/.claude-plugin/plugin.json` - plugin version
- `.claude-plugin/marketplace.json` - marketplace plugin entry version
- `plugins/<name>/CHANGELOG.md` - changelog

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- DIRECTORY STRUCTURE -->

## Directory Structure

```text
claude-marketplace-template/
├── .claude-plugin/
│   └── marketplace.json
├── .github/
│   └── workflows/
│       └── release.yml
├── plugins/
│   └── base-plugin/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── hooks/
│       │   ├── hooks.json            # sample hook - replace or delete
│       │   └── example-guard.sh
│       ├── skills/
│       │   └── skill-creator/        # skill - Anthropic's, Apache-2.0
│       └── README.md
├── scripts/
│   └── generate-release-config.js
├── release-please-config.json
├── .release-please-manifest.json
├── CLAUDE.md
└── README.md
```

To add a plugin, create only `plugins/<name>/.claude-plugin/plugin.json` - `marketplace.json`, the Release Please config and version bumps are all handled by CI.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

Released into the public domain under [The Unlicense](https://unlicense.org/) - do whatever you want with it. See `LICENSE`.

One exception: the `plugins/base-plugin/skills/skill-creator/` skill is Anthropic's, under the Apache License 2.0 (terms in that folder's `LICENSE.txt`). Only that one skill is Apache-2.0 - everything else, including any skills you add yourself, is covered by The Unlicense.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

CHANGE_ME

Project Link: <https://github.com/CHANGE_ME_USERNAME/CHANGE_ME_REPO>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

- [Claude Marketplace Template](https://github.com/Nagell/claude-marketplace-template) - the starter this repo was generated from
- [skill-creator](plugins/base-plugin/skills/skill-creator/) - Anthropic's skill, under Apache-2.0
- [Claude Code](https://docs.claude.com/en/docs/claude-code)
- [Release Please](https://github.com/googleapis/release-please)
- [Best-README-Template](https://github.com/othneildrew/Best-README-Template)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->

[license-shield]: https://img.shields.io/badge/license-Unlicense-blue.svg?style=for-the-badge
[license-url]: ./LICENSE
[Claude]: https://img.shields.io/badge/Claude_Code-D97757?style=for-the-badge&logo=anthropic&logoColor=white
[Claude-url]: https://docs.claude.com/en/docs/claude-code
[Bash]: https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white
[Bash-url]: https://www.gnu.org/software/bash/
[GitHubActions]: https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white
[GitHubActions-url]: https://github.com/features/actions
[ConventionalCommits]: https://img.shields.io/badge/Conventional_Commits-FE5196?style=for-the-badge&logo=conventionalcommits&logoColor=white
[ConventionalCommits-url]: https://www.conventionalcommits.org/
