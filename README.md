# NixOS Flake Configuration

Modular, multi-user, and multi-host NixOS configuration powered by Nix Flakes and Home Manager.

For a beginner-friendly guide on adding apps and users, see [CONTRIBUTING.md](file:///etc/nixos/CONTRIBUTING.md).

## Repository Tree

```
/etc/nixos/
├── flake.nix                  # Central Flake entrypoint
├── flake.lock                 # Locked dependencies
├── configuration.nix          # Legacy rebuild fallback stub
├── README.md                  # Documentation
├── hosts/
│   └── gigabyte-g5kf/
│       ├── default.nix        # Host modules & user imports
│       └── hardware-configuration.nix
├── users/
│   └── david/
│       ├── default.nix        # System user settings & groups
│       └── home.nix           # Home Manager profile
└── modules/
    ├── core/
    │   └── common.nix         # Base OS & store GC optimization
    ├── desktop/
    │   └── hyprland.nix       # Hyprland compositor & XDG portals
    ├── hardware/
    │   ├── nvidia.nix         # NVIDIA drivers & Wayland vars
    │   └── tuxedo.nix         # Tuxedo/Clevo drivers & fan control
    └── home/
        ├── antigravity.nix    # Antigravity CLI package module
        └── bash.nix           # Reusable shell profile & aliases
```

## Management Commands

### Apply Configuration Changes
```bash
sudo nixos-rebuild switch --flake /etc/nixos#gigabyte-g5kf
```

### Validate Flake Syntax & Evaluation
```bash
nix flake check /etc/nixos
nixos-rebuild dry-build --flake /etc/nixos#gigabyte-g5kf
```
