kerboscript-mode
==========

kerboscript-mode is a very simple emacs mode. It provides fundamental
syntax highlighting and code indentation for kOS's kerboscript
language.

Installation
----------

To enable this mode within your emacs, just copy the
`kerboscript-mode.el` to a path known by emacs
(e.g. `~/.emacs.d/`). If you like to use a different folder, remeber
to add it to your `load-path` by:

    (add-to-list 'load-path "~/.emacs.d/kerboscript-mode")
    
Make sure to require kerboscript-mode bevore you use it. Simply append
the following line to your `~/.emacs`
    
    (require 'kerboscript-mode)
    
Loading
----------

As kOS scripts are usually `.txt` files, just load the mode by hand
after opening a kerboscript file via:

    M-x kerboscript-mode

Yasnippets
----------

This repository also includes some simple snippet files for the
[yasnippets](https://github.com/rejeep/yasnippets) mode. Copy the
`kerboscript-mode` folder (the one with the `if`, `whn`, ... files in
it) into your snippets folder, usually at: `~/.emacs.d/snippets/`
