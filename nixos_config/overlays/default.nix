{ inputs, ... }:
{
    modifications = final: prev: import ./asusctl_overlay.nix { old = prev; new = final;};
}