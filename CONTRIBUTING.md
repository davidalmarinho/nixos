# Beginner's Guide: Contributing & Customizing Your NixOS Config

Welcome! This guide explains how to add new applications, configure users, and update your system step-by-step.

---

## 1. How to Add a New System-Wide Application

System-wide applications are available to **all users** on the computer.

1. Search for package names online at [search.nixos.org](https://search.nixos.org/packages) or via terminal:
   ```bash
   nix search nixpkgs htop
   ```
2. Open [`modules/core/common.nix`](file:///etc/nixos/modules/core/common.nix).
3. Add the package name inside `environment.systemPackages`:
   ```nix
   environment.systemPackages = with pkgs; [
     vim
     wget
     git
     htop  # <-- Added new app here!
   ];
   ```
4. Save the file and apply changes (see [Section 4](#4-how-to-apply-your-changes)).

---

## 2. How to Add Applications Only to Your User (`david`)

User-specific apps are installed only in **your personal profile** without affecting other users.

### Option A: Direct Package Addition
Open [`users/david/default.nix`](file:///etc/nixos/users/david/default.nix) or [`users/david/home.nix`](file:///etc/nixos/users/david/home.nix) and add the app:

```nix
# Inside users/david/default.nix (system user profile)
users.users.david = {
  isNormalUser = true;
  packages = with pkgs; [
    tree
    vscode   # <-- Added VSCode for david!
    vlc      # <-- Added VLC media player!
  ];
};
```

### Option B: Create a Modular Home App Config
1. Create a new file in `modules/home/`, e.g. [`modules/home/git.nix`](file:///etc/nixos/modules/home/git.nix):
   ```nix
   # modules/home/git.nix
   { config, pkgs, ... }:

   {
     programs.git = {
       enable = true;
       userName = "David";
       userEmail = "david@example.com";
     };
   }
   ```
2. Import it in [`users/david/home.nix`](file:///etc/nixos/users/david/home.nix):
   ```nix
   imports = [
     ../../modules/home/bash.nix
     ../../modules/home/antigravity.nix
     ../../modules/home/git.nix   # <-- Imported here!
   ];
   ```

---

## 3. How to Add a Brand New User (e.g., `alice`)

To add a second user `alice` to your system:

### Step A: Create User Directory & System Profile
Create directory `users/alice/` and create [`users/alice/default.nix`](file:///etc/nixos/users/alice/default.nix):

```nix
# users/alice/default.nix
{ config, pkgs, ... }:

{
  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Grants sudo rights if desired
    packages = with pkgs; [
      firefox
      discord
    ];
  };
}
```

### Step B: Create Home Manager Profile
Create [`users/alice/home.nix`](file:///etc/nixos/users/alice/home.nix):

```nix
# users/alice/home.nix
{ config, pkgs, ... }:

{
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  home.stateVersion = "26.05";

  imports = [
    ../../modules/home/bash.nix
  ];
}
```

### Step C: Register User in Host & Flake
1. In [`hosts/gigabyte-g5kf/default.nix`](file:///etc/nixos/hosts/gigabyte-g5kf/default.nix), add `alice` to `imports`:
   ```nix
   imports = [
     ../../modules/core/common.nix
     ../../modules/desktop/hyprland.nix
     ../../modules/hardware/nvidia.nix
     ../../users/david
     ../../users/alice   # <-- Add new user system config!
     ./hardware-configuration.nix
   ];
   ```

2. In [`flake.nix`](file:///etc/nixos/flake.nix), register `alice` under `home-manager.users`:
   ```nix
   home-manager = {
     useGlobalPkgs = true;
     useUserPackages = true;
     extraSpecialArgs = { inherit inputs; };
     users = {
       david = import ./users/david/home.nix;
       alice = import ./users/alice/home.nix;  # <-- Add new user home manager!
     };
     backupFileExtension = "backup";
   };
   ```

---

## 4. How to Apply Your Changes

Nix Flakes only read files tracked by Git. Always stage new files before rebuilding!

```bash
# 1. Stage all new or modified files in git
git -C /etc/nixos add .

# 2. Test for syntax/eval errors without building
nix flake check /etc/nixos

# 3. Apply your changes to your system
sudo nixos-rebuild switch --flake /etc/nixos#gigabyte-g5kf
```
