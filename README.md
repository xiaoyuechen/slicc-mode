# slicc-mode

An Emacs major mode for editing [gem5](https://www.gem5.org/) SLICC (`.sm`)
cache-coherence protocol files.

It's derived from `c-mode`, so indentation, brace/paren matching, and
comment/string handling come for free. On top of that it adds font-lock
rules for SLICC's own vocabulary: `machine`, `in_port`/`out_port`,
`action`, `transition`, `structure`, `enumeration`, common SLICC/Ruby
types, and the `ALL_CAPS` convention SLICC protocols use for states and
events.

## Installation

### Manual

Clone this repo somewhere on your `load-path`:

```elisp
(add-to-list 'load-path "/path/to/slicc-mode")
(require 'slicc-mode)
```

`.sm` files will then automatically open in `slicc-mode`.

### Nix

See the project's `flake.nix` for an example of building this as an
Emacs package with `emacsPackages.trivialBuild` and pulling it into an
Emacs derivation via `emacsWithPackages`.

## License

GPL-3.0, see `LICENSE`.
