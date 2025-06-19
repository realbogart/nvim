{
  description = "My neovim setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    self.submodules = true;
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        nvim-config = self;

        dependencies = with pkgs; [
          neovim
          ripgrep
          git
          nil
          nixfmt-classic
          stylua
          fzf
          prettierd
          jq
        ];
      in rec {
        packages.default = pkgs.writeShellApplication {
          name = "nvim-johan";
          runtimeInputs = dependencies;
          text = ''
            export XDG_CONFIG_HOME=${nvim-config}
            export NVIM_APPNAME='./'
            export TERM=tmux-256color
            export LANG=en_US.UTF-8
            nvim "$@"
          '';
        };

        devShells.default = pkgs.mkShell {
          packages = dependencies ++ [ packages.default ];
          shellHook = ''

            echo "Neovim development environment loaded"
            echo "Run 'nvim-johan' to start neovim with the full configuration"
          '';
        };
      });
}
