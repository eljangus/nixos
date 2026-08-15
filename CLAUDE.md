# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal NixOS / nix-darwin flake configuration with home-manager, covering
multiple hosts/desktops from one shared module tree. Not a general-purpose
project — it's tailored to the owner's specific hardware (`systems/Apollo`,
`systems/Mac`).

## Commands

```bash
nh os switch .#wc        # build+switch NixOS host `wc` (Niri, user elias)
nh os switch .#kde       # build+switch NixOS host `kde` (Plasma 6, user kdelias)
nh os switch .#gnome     # build+switch NixOS host `gnome` (GNOME, user gelias)
nh darwin switch .#mac   # build+switch nix-darwin host `mac` (OmniWM, user elias)

nix fmt                  # format with alejandra (the flake's `formatter`)
tack update               # refresh .tack/pins.lock.json from .tack/pins.toml
```

There is no test suite, linter, or CI in this repo. `nix flake check` /
`nixosConfigurations.<host>.config.system.build.toplevel` builds are the
practical way to validate a change compiles; prefer `nh os build .#<host>`
over a full switch when just checking that something evaluates.

Inputs are pinned by **tack** (`.tack/pins.toml` is the source of truth,
`.tack/pins.lock.json` the lockfile) instead of `flake.lock` — `nix flake
update` is a no-op here; use `tack update`.

## Architecture

### Two-axis module tree

Everything under `modules/` is split along two axes: **platform**
(`common` / `nixos` / `darwin`) and **layer** (`modules/system/*` for
system-level config, `modules/home-manager/*` for home-manager config).
`modules/system/common` is imported by both `nixosSystem` and
`darwinSystem` builds (see `flake.nix`'s `commonModules`); `nixos` and
`darwin` subtrees are only imported by their respective platform.

### Directory-tree auto-import

`lib/import-tree.nix` recursively imports every `*.nix` file under a
directory, **except** `default.nix` files and any file prefixed with `_`
(e.g. `_files/` dirs holding non-Nix assets like dotfiles/configs are
skipped entirely). This means adding a new module is just: drop a `.nix`
file anywhere in the tree and it's picked up automatically — no manual
import list to edit. `default.nix` at each directory level is the hand
written entry point that calls `importTree ./.` plus anything that needs
explicit ordering (see `hosts/wc/default.nix` for an example that also
pulls in a system profile and a user via `mk-user.nix`).

### Everything is gated by `myModules.*` options

Every module is wrapped in `lib.mkIf config.myModules.<path>.enable`
(e.g. `modules/system/nixos/programs/steam.nix`), so importing a module
file is not sufficient to activate it — the matching option must also be
enabled. Options are declared centrally, not next to their modules:

- `modules/system/common/options.nix` — shared system options
- `modules/system/nixos/options.nix` — Linux-only system options
- `modules/system/darwin/options.nix` — Darwin-only system options
- `modules/system/common/hm-options.nix`, `nixos/hm-options.nix`,
  `darwin/hm-options.nix` — the equivalents for home-manager modules,
  namespaced under `myModules.home-manager.*`

A host's `default.nix`/`modules.nix` sets these flags to opt into the
modules it wants (see `hosts/wc/modules.nix`). When adding a new module,
also add its enable option to the matching `options.nix`/`hm-options.nix`.

### Hosts vs systems vs users

- `hosts/<name>/` — per-desktop entry point: which modules are enabled
  (`modules.nix`) and which extra packages are installed (`pkgs.nix`).
  `wc`, `kde`, `gnome` all build the same physical machine (`Apollo`)
  with a different desktop/user layered on top; `mac` is the separate
  Darwin machine.
- `systems/<Machine>/` — hardware config, networking, machine-wide
  toggles that don't change between desktop variants (e.g.
  `systems/Apollo/hardware-configuration.nix`).
- Users are created via `lib/mk-user.nix`, which takes a `name` + `host`
  and produces both the system user account and the matching
  home-manager user config (imports `modules/home-manager/common` plus
  the platform-specific tree) in one call — see the `mk-user.nix` import
  inside each `hosts/<name>/default.nix`.

### home-manager wiring

`flake.nix` sets `home-manager.sharedModules` to include the `nvf`
neovim module and passes `inherit self inputs importTree` as
`extraSpecialArgs`, so home-manager modules have the same `self` /
`importTree` helpers available as system modules.

## Conventions

- Nix files are formatted with `alejandra` (`nix fmt`); match its style
  (2-space indent, no manual reformatting).
- Don't hardcode a new module's enable check — always gate `config` with
  `lib.mkIf config.myModules.<...>.enable`, matching the existing
  modules.
- Dotfiles/static assets that modules reference (niri config, kitty
  themes, fastfetch configs, etc.) live in `_files/` subdirectories next
  to the module that uses them and are intentionally excluded from
  `import-tree`'s auto-import.
