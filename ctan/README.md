# gyoudori

A LaTeX package for gyou-dori (line-based placement) in Japanese typesetting: it
places headings, display math and floats in areas of whole lines, so that the
lines of the main text stay on the line grid.

Version 20261026.0, 2026-10-26.
Author: Yuwsuke Kieda

A Japanese README is in `README-ja.md`.

## Description

*Gyou-dori* (行取り, also written 行ドリ) is one of the arbitrary layouts: the
block-direction space of an element whose size differs from the main text, such
as a heading, is determined as a number of lines of the kihon-hanmen (the basic
page format), so that the following lines of the main text stay on the line
positions of the kihon-hanmen (the line grid). It is used in typesetting
Japanese books and the like when such a line grid is specified. This package is
a tool for cases where one has to typeset under such a specification.

The area of an 𝑛-line gyou-dori is

    character frame × 𝑛 + line gap × (𝑛 − 1)
      = line pitch × (𝑛 − 1) + character frame

(JLREQ, W3C *Requirements for Japanese Text Layout*, §4.1.6).

- The `gyoudori` environment and the `\gyoudoriarea` command place their
  content in an 𝑛-line area (top, center or bottom), positioned by the
  character frames of the content. With the `local` option they follow the
  current font size and `\baselineskip`, so that they also work inside `\small`
  and the like. Content that does not fit causes a warning (or an error).
- Option `displaymath`: display math (`equation`, `\[ \]`, `eqnarray`, and
  `equation*`, `align`, `gather`, `multline`, `flalign`, `alignat` of amsmath,
  with their starred forms) is centered by its baselines in an area of the
  number of lines it needs plus one (at least two; changeable with
  `displaymathextra`). It follows the current font size and `\baselineskip`,
  so displays in footnotes or in parts set in `\small` stay on the surrounding
  line pitch.
- Option `float`: floats are put into the smallest gyou-dori area and aligned
  to the line grid; the float separations are rounded to whole lines.
  Float-only pages are aligned to the grid as well. Works with nidanfloat,
  stfloats, flushend and evenend.

## Usage

```latex
\usepackage[displaymath,float]{gyoudori}

\begin{gyoudori}[c]{3}  % position t|c|b (default c), number of lines
A heading
\end{gyoudori}

\gyoudoriarea[b]{2}{A heading}
```

The optional argument of the `gyoudori` environment and `\gyoudoriarea` is a
comma-separated list of a position (`t`, `c`, `b`), `local`, and `indent` or
`noindent`.

| Package option | Value | Default | Meaning |
|---|---|---|---|
| `displaymath` | true/false | false | gyou-dori for display math |
| `displaymathextra` | integer ≥ 0 | 1 | lines added to the lines a display needs |
| `float` | true/false | false | gyou-dori for floats |
| `overflow` | warning/error | warning | when the content does not fit in the area |
| `indent` | true/false | false | indent the content of `gyoudori` / `\gyoudoriarea` |
| `floatsep`, `textfloatsep`, `intextsep`, `dblfloatsep`, `dbltextfloatsep` | length | class value | set the length |

## Requirements

- pLaTeX, upLaTeX, or LuaLaTeX with LuaTeX-ja (e.g. jarticle, ujarticle,
  ltjsarticle, jlreq). Designed for horizontal writing; vertical writing is not
  considered (see the limitations in the manual).
- LaTeX 2022-06-01 or later. No other package is required.
- Tested with pLaTeX, upLaTeX and LuaLaTeX in TeX Live 2025 and 2026.

## Documentation

The manuals are in English and Japanese, with the same contents: gyou-dori
explained with figures, the usage, the relation to JLREQ, how it works, and the
limitations.

- `doc/gyoudori-en.pdf`, `doc/gyoudori-ja.pdf`: the manuals.
- `doc/gyoudori-en.tex`, `doc/gyoudori-ja.tex`, `doc/gyoudori-fig.tex`: their
  sources (typeset with pLaTeX and dvipdfmx; `gyoudori-fig.tex` draws the
  figures and needs TikZ).

## Installation

| Files | Location |
|---|---|
| `tex/gyoudori.sty` | `tex/latex/gyoudori/` |
| `doc/*`, `README.md`, `README-ja.md`, `LICENSE` | `doc/latex/gyoudori/` |

## License

MIT License (`LICENSE`).
