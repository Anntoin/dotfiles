## Dotfiles

This is my dotfiles repo, there are many like it ;)

Uses [home-manager](https://nix-community.github.io/home-manager/) to manage the configuration for several machines.

Home Manager has a number of nice benefits beyond what most dotfile manager tools
provide:

1. more than just dotfiles, actually manages the packages themselves
   from the extensive (and fairly up-to-date) [NixPkgs](https://search.nixos.org/packages?channel=unstable)
2. Allows clean rollbacks (`home-manager switch --rollback`)
3. Consistent and integrated configuration for popular [`programs`](https://home-manager-options.extranix.com/?query=programs&release=master)
4. Can manage user [`services`](https://home-manager-options.extranix.com/?query=services&release=master)!

In any case was enough to convince me to take the plunge. While the learning
curve can be a bit steep and the documentation inscrutable at times I've been happy with it so far.

Home-manager (and Nix in general) allows a lot of freedom in how you structure and manage your configuration. I hope others might find my take on things helpful on their Nix journey.

### Prerequsites:

- `nix`: Most of my hosts are Arch so `# pacman -S nix` and `# systemctl enable --now nix-daemon` does the trick.

### Setup

- `git clone git@github.com:anntoin/dotfiles.git ~/.config/home-manager/`
- `cd ~/.config/home-manager`
- `home-manager switch --flake .`

This only needs to be done on the initial run, updates are done automatically afterwards.

### Use

After updating any files you'll need to run `home-manager switch` to deploy your
changes. There are ways to get around this but I haven't found it to be much of
a hassle and it can make you be a bit more deliberate when making changes.

To update package versions (once they've landed in NixPkgs) you'll need to
update the `flake.lock` file. Just manually run `nix flake update` and, all
being good, commit that version. Once other hosts pull down that version
automatic updates will take care of the rest.
