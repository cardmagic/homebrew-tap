# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal Homebrew tap (`cardmagic/tap`) containing formulae for macOS CLI tools.

## Testing Formulas

**Important:** The tap at `/opt/homebrew/Library/Taps/cardmagic/homebrew-tap` is linked to the GitHub remote. Local changes here won't affect brew until pushed.

### Quick SHA256 Verification (Do This First)

Before testing any formula, verify the SHA256 hash matches:

```bash
# npm packages
curl -sL "https://registry.npmjs.org/@cardmagic/<pkg>/-/<pkg>-<version>.tgz" | shasum -a 256

# GitHub releases
curl -sL "https://github.com/cardmagic/<repo>/archive/refs/tags/v<version>.tar.gz" | shasum -a 256
```

If the SHA doesn't match, update the formula before testing.

### Testing After Changes

1. **Commit and push the formula change**
2. **Update the tap:** `brew update`
3. **Install:** `brew install cardmagic/tap/<formula>` or `brew reinstall cardmagic/tap/<formula>`

There's no way to test local formula files without pushing - Homebrew rejects non-tap paths.

### Troubleshooting

**Download failed / SHA mismatch:** npm packages can be republished. Verify SHA256 and update formula.

**Ruby formula fails with LoadError:** Stale gems linked against old Ruby. Fix with:
```bash
rm -rf /opt/homebrew/lib/ruby/gems/3.4.0/gems/* /opt/homebrew/lib/ruby/gems/3.4.0/extensions/*
brew install cardmagic/tap/classifier
```

**Formula from wrong tap:** Uninstall first, then reinstall from correct tap:
```bash
brew uninstall <formula>
brew install cardmagic/tap/<formula>
```

### Verification

After installation, verify the CLI works:
```bash
messages --version  # Should output version number
notes --version
reminders --version
classifier --version
```

## Formula Types

**Node.js packages** (messages, notes, reminders): Pull from npm registry, use `std_npm_args`, macOS-only.

**Ruby gems** (classifier): Pull from GitHub releases, bundle gem dependencies as resources, build from gemspec.

## Updating a Formula

1. Update `url` with new version/tag
2. Update `sha256` (verify with curl + shasum)
3. For Ruby formulae: update resource blocks if gem versions changed
4. Commit, push, then `brew update && brew reinstall cardmagic/tap/<formula>`

## Other Commands

```bash
# Audit formula for issues
brew audit --strict --online Formula/<name>.rb

# Run formula tests (after installation)
brew test cardmagic/tap/<name>

# Check tap info
brew tap-info cardmagic/tap
```
