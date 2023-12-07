# tabline.vim

A [fork of mkitt's](https://github.com/mkitt/tabline.vim) plugin.

Configure tab labels within terminal Vim with even more succinct output.

Before:
![Tabline before screenshot](https://raw.github.com/mkitt/tabline.vim/master/screenshots/tabline.png)

After:
![Tabline after screenshot](https://raw.github.com/mkitt/tabline.vim/master/screenshots/tabline.png)

- Tab number
- Filename: base . extension
    - if desired, filename can be shortened to a given number of characters
- [+] if the current buffer has been modified

Tabs in this case, refer to Vim Tabs and not the Terminal.app tabs.

Based on settings found from [offensive thinking](http://www.offensivethinking.org/data/dotfiles/vimrc) and, of course, [mkitt's plugin](https://github.com/mkitt/tabline.vim) plugin.

## Configuration
Make sure to set the following settings within your color theme: 

```
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
```

To enable shortening of the filenames, set `g:tablinemaxwidth` in your `vimrc/init.vim`
```
let g:tablinemaxwidth=18
```
Shortening is done in three steps:
- extension is shortened to no more than `3` characters (excluding `.`), starting at the back. For example:
```
.blend
```
becomes:
```
.end
```
- file name consists of equal (or off by one, for obvious reason) number of characters, taken from front and back of the original file name with a single `#` character representing the shortened part:
- bufname is simply `.` concatenated file name and extension. For example, with `g:tablinemaxwidth` set to `18`:
```
OcctoIRegInstrumentation.cpp
```
becomes:

```
|-6--|1|--7--|1|3|
OcctoI#ntation.cpp
```
where the filename is formed of `14` (`6 + 1 + 7`), `1` for the `.` and finally `3` characters for the extension.
