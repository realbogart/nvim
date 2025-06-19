{
  description = "My neovim setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        nvim-config = if (self ? rev) then
          # Remote usage - fetch from GitHub with submodules
          builtins.fetchGit {
            url = "https://github.com/realbogart/nvim.git";
            rev = self.rev;
            submodules = true;
          }
        else
          # Local usage - use self directly
          self;

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
            # Check if submodules are available
            if [ ! -f "${nvim-config}/plugins/lazy.nvim/lua/lazy/init.lua" ]; then
              echo "✗ Error: lazy.nvim plugin not found."
              echo ""
              echo "For local usage, initialize submodules first:"
              echo "  git submodule update --init --recursive"
              echo "  nix run ."
              echo ""
              exit 1
            fi
            
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
