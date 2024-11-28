<h1 align = "center">
Welcome to termtools.nvim!
</h1>

<p align="center">
`termtools.nvim` is a plugin providing a set of small qualitiy of life features for my current favourite editor
and IDE <a href="github.com/Lunarvim/LunarVim">LunarVim</a>
</p>

## Features

Currently, `termtools.nvim` provides the following features:

- Multiline editing
- Text Search and Replace

## Installation

You can install this plugin using [Lazy.nvim](https://github.com/folke/lazy.nvim).

Simply add this line to your LunarVim config file at `~/.config/lvim/config.lua`:

```Lua
lvim.plugins = {
    {
        "git@github.com:BytePaws/sysmon.nvim"
    }
}
```

After installation - by default - all features are active at once.

> [!Note]
> This plugin was developed specifically with and for LunarVim. It may be possible that it works
> with other NeoVim configurations using the `telescope.nvim` and `treesitter.nvim` plugins
> but I do not guarantee it.
>
> If you encounter any problems, please [report them](https://github.com/BytePaws/termtools.nvim).

## Requirements

- NeoVim 0.5 or higher
- LunarVim v1.4 or newer (tested with 1.4, older versions might work, might not)

