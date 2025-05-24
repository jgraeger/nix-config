# Personal NixOS config

My personal configuration for NixOS/Home-Manager.

All of this is work-in-progress and unpolished. Feel free to look around but I'd advise to not use anything yet.

## Hosts

I started this for a reproducible setup of my Raspberry PI, that ran some services in the network. While not done with that, I also started to experiment with a configuration for my workstation.

Currently, two hosts are reflected in the configuration

- **lake**: Main Workstation (Intel 12th Gen CPU).
- **rubus**: Raspberry PI 4 for some network services.

I'll defenitly have a look at `nix-darwin` for home manager configuration on my mobile devices as well.

## Secrets

For deployment secrets, I use [`sops-nix`](https://github.com/Mic92/sops-nix). The primary key for encrypting and decrypting secrets during development is stored on my YubiKey. [`age-plugin-yubikey`](https://github.com/str4d/age-plugin-yubikey) integrates seamless with this workflow, just set the `SOPS_AGE_KEY` environment variable (not reflected in this repo yet).

## Acknowledgements

Since this started as an experiment without any prior Nix/NixOS experience, most of the content is shamelessly copied from other configurations posted on GitHub. Some who defenitly had an influence and in the hope to not forget anyone:

- [Mic92](https://github.com/Mic92) - For the amazing tooling they build.
- [Misterio77](https://github.com/Misterio77) - My starting point for the initial structure.
- [EmergentMind](https://github.com/EmergentMind) - For the videos on secret management and also some of the structural considerations.
- [MyLinuxForWork](https://github.com/mylinuxforwork/dotfiles) - Using their dotfiles repo for the initial hyprland workstation config, while transfering it to the nix configuration.
