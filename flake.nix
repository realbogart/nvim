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

        # Use current directory (without submodules, we'll handle them separately)
        nvim-config = ./.;

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
            
            # Copy base configuration (without plugins)
            cp -a ${nvim-config}/. "$XDG_CONFIG_HOME/nvim-johan"/
            chmod -R u+w "$XDG_CONFIG_HOME"
            
            # Remove any empty plugins directory that might have been copied
            rm -rf "$XDG_CONFIG_HOME/nvim-johan/plugins"
            
            # Copy plugins from the current working directory (where user runs the command)
            # This assumes the user runs nix run from the nvim config directory
            if [ -d "./plugins" ]; then
              cp -a "./plugins" "$XDG_CONFIG_HOME/nvim-johan/"
            elif [ -d "$PWD/plugins" ]; then
              cp -a "$PWD/plugins" "$XDG_CONFIG_HOME/nvim-johan/"
            else
              echo "Error: plugins directory not found in current directory"
              echo "Make sure to run 'nix run' from the nvim directory with initialized submodules"
              echo "Current directory: $PWD"
              echo "Run: git submodule update --init --recursive"
              exit 1
            fi
            export NVIM_APPNAME='nvim-johan'
            export TERM=tmux-256color
            export LANG=en_US.UTF-8
            
            # Verify setup
            if [ ! -d "$XDG_CONFIG_HOME/nvim-johan/plugins/lazy.nvim" ]; then
              echo "✗ Error: lazy.nvim not found. Make sure git submodules are initialized:"
              echo "  git submodule update --init --recursive"
              exit 1
            fi
            
            nvim "$@"
          '';
        };

        devShells.default = pkgs.mkShell {
          packages = dependencies ++ [ packages.default ];
          shellHook = ''
            echo "Neovim development environment loaded"
            echo "Run 'nvim-johan' to start neovim with the local configuration"
          '';
        };
      });
}

