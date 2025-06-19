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

            XDG_CONFIG_HOME=$(mktemp -d)
            export XDG_CONFIG_HOME
            mkdir -p "$XDG_CONFIG_HOME/nvim-johan"

            # Copy the complete configuration including plugins
            cp -a ${nvim-config}/. "$XDG_CONFIG_HOME/nvim-johan"/
            chmod -R u+w "$XDG_CONFIG_HOME"

            export NVIM_APPNAME='nvim-johan'
            export TERM=tmux-256color
            export LANG=en_US.UTF-8

            # Verify that lazy.nvim exists and has content
            if [ ! -f "$XDG_CONFIG_HOME/nvim-johan/plugins/lazy.nvim/lua/lazy/init.lua" ]; then
              echo "✗ Error: lazy.nvim plugin not found or incomplete."
              echo ""
              echo "For local usage:"
              echo "  git submodule update --init --recursive"
              echo "  nix run ."
              echo ""
              echo "For remote usage:"
              echo "  nix run 'github:realbogart/nvim?submodules=1'"
              echo ""
              exit 1
            fi

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
