{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles = {
      Default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;

        extensions = with pkgs.vscode-extensions; [
          streetsidesoftware.code-spell-checker
          tamasfe.even-better-toml
          github.vscode-pull-request-github
          davidanson.vscode-markdownlint
          gruntfuggly.todo-tree
          tomoki1207.pdf
          spadin.zmk-tools
        ];

        userSettings = {
          "files.autoSave" = "afterDelay";
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;

          "editor.formatOnSave" = true;

          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[markdown]" = {
              "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
          };
          "[toml]" = {
              "editor.defaultFormatter" = "tamasfe.even-better-toml";
          };

          "git.autofetch" = true;
          "git.confirmSync" = false;
          "diffEditor.codeLens" = true;

          "todo-tree.ripgrep.ripgrep" = "/usr/bin/rg";

          "workbench.colorTheme" = "Dark+";
          "workbench.iconTheme" = "vs-seti";
          "workbench.activityBar.location" = "top";
          "editor.minimap.autohide" = "mouseover";
          "telemetry.telemetryLevel" = "off";
        };
      };

      APA = {
        extensions = with pkgs.vscode-extensions; [
          streetsidesoftware.code-spell-checker
          vadimcn.vscode-lldb
          connor4312.esbuild-problem-matchers
          dbaeumer.vscode-eslint
          tamasfe.even-better-toml
          ms-vscode.extension-test-runner
          github.vscode-pull-request-github
          davidanson.vscode-markdownlint
          christian-kohler.npm-intellisense
          esbenp.prettier-vscode
          yoavbls.pretty-ts-errors
          rust-lang.rust-analyzer
          gruntfuggly.todo-tree
        ];
        userSettings = {
          "files.autoSave" = "afterDelay";
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;

          "editor.formatOnSave" = true;

          "[markdown]" = {
              "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
          };
          "[toml]" = {
              "editor.defaultFormatter" = "tamasfe.even-better-toml";
          };

          "git.autofetch" = true;
          "git.confirmSync" = false;
          "diffEditor.codeLens" = true;

          "todo-tree.ripgrep.ripgrep" = "/usr/bin/rg";

          "workbench.colorTheme" = "Dark+";
          "workbench.iconTheme" = "vs-seti";
          "workbench.activityBar.location" = "top";
          "editor.minimap.autohide" = "mouseover";
          "telemetry.telemetryLevel" = "off";
        };
      };

      FLL = {
        extensions = with pkgs.vscode-extensions; [
          streetsidesoftware.code-spell-checker
          tamasfe.even-better-toml
          github.vscode-pull-request-github
          davidanson.vscode-markdownlint
          ms-python.python
          charliermarsh.ruff
          gruntfuggly.todo-tree
        ];
        userSettings = {
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "diffEditor.codeLens" = true;

          "todo-tree.ripgrep.ripgrep" = "/usr/bin/rg";

          "workbench.colorTheme" = "Dark+";
          "workbench.iconTheme" = "vs-seti";
          "workbench.activityBar.location" = "top";
          "editor.minimap.autohide" = "mouseover";
          "telemetry.telemetryLevel" = "off";
        };
      };

      NixOS = {
        extensions = with pkgs.vscode-extensions; [
          davidanson.vscode-markdownlint
          gruntfuggly.todo-tree
          kamadorueda.alejandra
          jnoortheen.nix-ide
        ];

        userSettings = {
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nil}/bin/nil";
          "nix.serverSettings.nil.formatting.command" = [
            "${pkgs.alejandra}/bin/alejandra"
          ];

          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
            "editor.formatOnSave" = true;
          };
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "diffEditor.codeLens" = true;

          "todo-tree.ripgrep.ripgrep" = "/usr/bin/rg";

          "workbench.colorTheme" = "Dark+";
          "workbench.iconTheme" = "vs-seti";
          "workbench.activityBar.location" = "top";
          "editor.minimap.autohide" = "mouseover";
          "telemetry.telemetryLevel" = "off";
        };
      };

      WEB = {
        extensions = with pkgs.vscode-extensions; [
          formulahendry.auto-rename-tag
          biomejs.biome
          streetsidesoftware.code-spell-checker
          github.vscode-pull-request-github
          ecmel.vscode-html-css
          davidanson.vscode-markdownlint
          gruntfuggly.todo-tree
          tomoki1207.pdf
        ];

        userSettings = {
          "editor.formatOnSave" = true;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "diffEditor.codeLens" = true;

          "editor.defaultFormatter" = "biomejs.biome";
          "[markdown]" = {
            "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
          };
          "[toml]" = {
            "editor.defaultFormatter" = "tamasfe.even-better-toml";
          };

          "todo-tree.ripgrep.ripgrep" = "/usr/bin/rg";

          "workbench.colorTheme" = "Dark+";
          "workbench.iconTheme" = "vs-seti";
          "workbench.activityBar.location" = "top";
          "editor.minimap.autohide" = "mouseover";
          "telemetry.telemetryLevel" = "off";
        };
      };
    };
  };
}


