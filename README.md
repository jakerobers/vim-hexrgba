# HexRgba

A Vim plugin that toggles between hex and rgba color codes for css/sass/less
editing. Are you tired of manually looking up the conversions of these codes?  I
am too.

Why use rgba instead of rgb? I am of the opinion that rgba should only be used
when needing to add transparency to a color. If a color does not require
transparency, I use hex out of personal preference.

## Installation

**Plug**

```
Plug 'jakerobers/vim-hexrgba'
```

**Pathogen**

```
cd ~/.vim/bundle
git clone git@github.com:jakerobers/vim-hexrgba.git
```

## Mapping

You can map a key to the `:HexRgba` command. Here is the key that I use:

```
nnoremap <leader>h :HexRgba<CR>
```

## Usage

Using the command `:HexRgba` will toggle the codes. You can also use the map if
you set one.

**Converts hex to rgba**

```
color: #FFFFFF;
```

**Converts rgba to hex**

```
background-color: rgba(0, 0, 0, .1);
```

**Converts rgb to hex**

```
background-color: rgb(0, 0, 0, .1);
```

