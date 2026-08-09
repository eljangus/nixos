# ❄️ nixos

**My personal NixOS/Nix-Darwin setup with support for multiple hosts.**

Application dotfiles (niri, noctalia, fastfetch, kitty) are managed
imperatively and live [**here**](https://github.com/eljangus/dotfiles).

<div align="center">

## ❄️ NixOS · Niri · Noctalia

**The NNN stack**, running on `wc` and my main setup.

![ss1](./assets/screenshots/1.png) ![ss2](./assets/screenshots/2.png)

## 🍏 Nix-Darwin 

**MacOS running OmniWM and Nix-Darwin, my university and productivity setup.**

![ss3](./assets/screenshots/3.png)
</div>

---

## 🖥️ Hosts

3 build the same machine, **`Apollo`**, with a different desktop and
user bolted on top:

| Host    | User      | Desktop     | Purpose                                |
| :-----: | :-------: | :---------: | :------------------------------------: |
| `wc`    | `elias`   | Niri        | Daily driver                           |
| `kde`   | `kdelias` | Plasma 6    | For when I want a customizable desktop |
| `gnome` | `gelias`  | GNOME       | For when I want a good desktop OOTB    | 

And 1 builds on my MacBook Pro, **`Mac`**, with MacOS running OmniWM:

| Host    | User      | Desktop     | Purpose                                |
| :-----: | :-------: | :---------: | :------------------------------------: |
| `mac`   | `elias`   | OmniWM      | Productivity device for University     |


```bash
nh os switch .#wc      # niri
nh os switch .#kde     # plasma 
nh os switch .#gnome   # gnome
:-------------------------------:
nh darwin switch .#mac # macos
```

---

## 🗂️ Layout

<details>
<summary><b>The whole tree</b> (click to expand)</summary>

```
.
├── .tack
│   ├── default.nix
│   ├── pins.lock.json
│   └── pins.toml
├── assets
│   └── screenshots
│       ├── 1.png
│       ├── 2.png
│       └── 3.png
├── hosts
│   ├── gnome
│   │   ├── default.nix
│   │   ├── modules.nix
│   │   └── pkgs.nix
│   ├── kde
│   │   ├── default.nix
│   │   ├── modules.nix
│   │   └── pkgs.nix
│   ├── mac
│   │   ├── default.nix
│   │   ├── modules.nix
│   │   └── pkgs.nix
│   └── wc
│       ├── default.nix
│       ├── modules.nix
│       └── pkgs.nix
├── lib
│   ├── import-tree.nix
│   └── mk-user.nix
├── modules
│   ├── common
│   │   ├── programs
│   │   │   ├── common-pkgs.nix
│   │   │   └── fish.nix
│   │   ├── system
│   │   │   ├── fonts.nix
│   │   │   └── nix.nix
│   │   ├── default.nix
│   │   └── options.nix
│   ├── darwin
│   │   ├── programs
│   │   │   ├── desktop-pkgs.nix
│   │   │   └── omniwm.nix
│   │   ├── system
│   │   │   ├── homebrew.nix
│   │   │   └── touchid.nix
│   │   ├── default.nix
│   │   └── options.nix
│   ├── home-manager
│   │   ├── common-programs
│   │   │   ├── default.nix
│   │   │   ├── fish.nix
│   │   │   ├── git.nix
│   │   │   ├── nvf.nix
│   │   │   └── starship.nix
│   │   ├── darwin-programs
│   │   │   ├── default.nix
│   │   │   ├── man.nix
│   │   │   └── nh.nix
│   │   ├── elias
│   │   │   ├── default.nix
│   │   │   └── xdg.nix
│   │   └── mac-elias
│   │       ├── default.nix
│   │       └── home.nix
│   └── nixos
│       ├── programs
│       │   ├── dconf.nix
│       │   ├── desktop-pkgs.nix
│       │   ├── firefox.nix
│       │   ├── gamescope.nix
│       │   ├── gpu-screen-recorder.nix
│       │   ├── nh.nix
│       │   ├── steam.nix
│       │   └── tack.nix
│       ├── system
│       │   ├── desktops
│       │   │   ├── gnome.nix
│       │   │   ├── hyprland.nix
│       │   │   ├── niri.nix
│       │   │   ├── plasma6.nix
│       │   │   └── sddm.nix
│       │   ├── overlays
│       │   │   ├── glaze.nix
│       │   │   ├── qt6ct-kde.nix
│       │   │   ├── sddm-astronaut.nix
│       │   │   └── swash.nix
│       │   ├── amdgpu.nix
│       │   ├── boot.nix
│       │   ├── environment.nix
│       │   ├── hardware.nix
│       │   ├── locale.nix
│       │   ├── openssh.nix
│       │   ├── polkit.nix
│       │   ├── services.nix
│       │   ├── time.nix
│       │   └── xkb.nix
│       ├── default.nix
│       └── options.nix
├── patches
│   └── qt6ct-shenanigans.patch
├── systems
│   ├── Apollo
│   │   ├── default.nix
│   │   ├── hardware-configuration.nix
│   │   ├── modules.nix
│   │   └── networking.nix
│   └── Mac
│       ├── default.nix
│       └── modules.nix
└── flake.nix
```

</details>

**short:**

| Directory        | What lives there                                              |
| :--------------: | :-----------------------------------------------------------: |
| `hosts/`         | Per-desktop entry points, which modules, which packages       |
| `systems/`       | Per-machine hardware, networking, machine-wide toggles        |
| `modules/`       | The actual configuration, split by platform                   |
| `lib/`           | `import-tree` and `mk-user`, two helpful libraries            |
| `.tack/`         | Input pins, the real lockfile replacing flake.lock            | 

---

## 📐 Conventions

### The platforms are split 

`modules/common` is imported by both `nixosSystem` and `darwinSystem`;
`modules/nixos` and `modules/darwin` only by their own.

### Options

Modules are toggled through a single option namespace, declared in:
`modules/common/options.nix` for the shared modules,
`modules/nixos/options.nix` for the Linux-only ones and
`modules/darwin/options.nix` for the Darwin-only ones:

```nix
# example
myModules = {
  desktop = "niri";
  system.overlays.enable = true;
  programs.gpu-screen-recorder.enable = true;
};
```
Every modules is a lib.mkIf statement, therefore to use a module importing it is not enough, it would also have to be enabled. for options see the respective options.nix file.

### Adding a module

`lib/import-tree.nix` imports each directory recursively, skipping `default.nix` and any file prefixed with `_`. So a new module is:

1. a new file, and
2. its option declaration in the matching `options.nix`.

That's it .

### Users

`lib/mk-user.nix` produces both the system account and the home-manager config from a name and a host. 

### Inputs

Pinned with [**tack**](https://github.com/manic-systems/tack), so `.tack/pins.toml` is the source of truth and `nix flake update` does nothing.
`tack update` refreshes the lock/inputs.

---

## 🧪 Using it

> [!WARNING]
> This is tailored to my hardware. Simply copying it won't be enough.

Before the first switch you'd need to:

- Replace `systems/Apollo/hardware-configuration.nix`
- Review `systems/Apollo/modules.nix` and/or `systems/Mac/modules.nix`
- Set your own name and email in `modules/home-manager/common-programs/git.nix`
- Place hashed password files at `/etc/nixos/secrets/<user>.txt`

---

## 💜 Credits

Big thanks to the people in the **#nixos** channel of the [**Noctalia Discord**](https://github.com/noctalia-dev/noctalia-shell), some honorable mentions:

- [*onoruu*](https://onoruu.neocities.org/)
- [*Stella*](https://github.com/iStellanova/stellyrland)
- [*Stalkingwolf*](https://github.com/Stalkingwolf23-glitch/nixos-dotfiles)
- [*Aria*](https://codeberg.org/princearia/nixos)
- [*sam*](https://github.com/samiser/nix-configs)
- [*Pengo*](https://forge.pengo.uk/pengo/nixos)
- [*LucasOe*](https://github.com/LucasOe/nixos-config)

---

## 📄 License

[MIT](LICENSE).
