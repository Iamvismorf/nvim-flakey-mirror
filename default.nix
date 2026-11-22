{
  pkgs,
  lib,
  ...
}: let
  lib' = import ./lib {inherit lib;};
in {
  aliases = ["vim"];
  initLua = ''
    require("vismorf")
  '';
  # neovim = inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
  extraBinPath =
    [
      pkgs.fzf
      pkgs.ripgrep
      pkgs.fd
    ]
    ++ [
      pkgs.alejandra
      pkgs.nixd
      pkgs.stylua
      pkgs.lua-language-server
      pkgs.shfmt
      pkgs.inotify-tools
      pkgs.kdePackages.qtdeclarative
      pkgs.llvmPackages.clang-tools
      pkgs.neocmakelsp
    ];
  enable = true;
  plugins = let
    sources = import ./+npins;
    pluh = lib'.npins2plugins sources;
  in {
    dev.myConfig = let
      fs = lib.fileset;
    in {
      pure = fs.toSource {
        root = ./nvim;
        fileset = fs.fromSource (lib.sources.cleanSource ./nvim);
      };

      impure = lib'.toAbsolutePath ./nvim;
    };
    start =
      builtins.attrValues {
        inherit (pkgs.vimPlugins) lze lzextras;
        inherit
          (pkgs.vimPlugins)
          nvim-web-devicons
          plenary-nvim
          snacks-nvim
          statuscol-nvim
          ;
      }
      ++ [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        (pluh.zen-nvim null)
        (pluh.south-nvim null)
      ];
    opt =
      builtins.attrValues {
        inherit (pkgs.vimPlugins) conform-nvim;
        inherit (pkgs.vimPlugins) friendly-snippets lspkind-nvim;

        inherit
          (pkgs.vimPlugins)
          nvim-ufo
          gitsigns-nvim
          bufferline-nvim
          nvim-cokeline
          indent-blankline-nvim
          mini-animate
          fzf-lua
          flash-nvim
          nvim-autopairs
          nvim-surround
          yazi-nvim
          bufjump-nvim
          nvim-highlight-colors
          crates-nvim
          ;
      }
      ++ [
        pkgs.vimPlugins.nvim-treesitter-textobjects
        pkgs.vimPlugins.nvim-treesitter-context

        #todo: remove this after upstream is merged
        (
          pkgs.vimPlugins.blink-cmp.overrideAttrs
          {
            src = pluh.blink-cmp.outPath;
          }
        )
      ];
  };
}
