# gyoudori — gyou-dori (line-based placement) for Japanese typesetting

- Author: Yuwsuke Kieda
- Version: v20261018.1 (2026-10-18)
- License: MIT
- Repository: https://github.com/yuw/texmf-gyoudori

## What is gyou-dori?

*Gyou-dori* (行取り, also written 行ドリ) is one of the arbitrary layouts: the
block-direction space of an element whose size differs from the main text, such
as a heading, is determined as a number of lines of the kihon-hanmen (the basic
page format), so that the following lines of the main text stay on the line
positions of the kihon-hanmen (the line grid). It is used in typesetting
Japanese books and the like when such a line grid is specified.
The area of an 𝑛-line gyou-dori is

    character frame × 𝑛 + line gap × (𝑛 − 1)
      = line pitch × (𝑛 − 1) + character frame.

By default this package places the content at the center of the area; top or
bottom alignment can be chosen with the position argument. Where to place the
content depends on the specification of each job.
See JLREQ (W3C *Requirements for Japanese Text Layout*), §2.5.2 and §4.1.6:
https://www.w3.org/TR/jlreq/#processing_of_gyoudori

Gyou-dori is called arbitrary because aligning lines to the grid is not in
itself a principle of readability. Such a layout is often
specified regardless of the benefit of readers; page design should rather pursue
that benefit without being tightly bound to the grid. This package is a tool for
cases where one has to typeset under such a specification.

## Features

- The `gyoudori` environment and the `\gyoudoriarea` command place their
  content in an 𝑛-line gyou-dori area (top, center or bottom), positioned by
  the character frames of the content. With the `local` option they follow the
  current font size and `\baselineskip`, so that they also work inside `\small`
  etc. Content that does not fit causes a warning (or an error).
- Option `displaymath`: display math (`equation`, `\[ \]`, `eqnarray`, and
  `equation*`, `align`, `gather`, `multline`, `flalign`, `alignat` of amsmath,
  with their starred forms) is centered by its baselines in the smallest area of at least
  two lines (a one-row display in an odd-line area sits on the middle line).
  It follows the current font size and `\baselineskip`, so displays in
  footnotes or in parts set in `\small` stay on the surrounding line pitch.
- Option `float`: floats are put into the smallest gyou-dori area and aligned to
  the line grid; the float separations are rounded to whole lines. Float-only
  pages are aligned to the grid as well.
  Works with nidanfloat, stfloats, flushend and evenend.

## Requirements

- pLaTeX, upLaTeX, or LuaLaTeX with LuaTeX-ja (e.g. ltjsarticle, jlreq);
  designed for horizontal writing (vertical writing is not considered; see the
  limitations in the manual)
- LaTeX 2020-10-01 or later
- kvoptions

## Installation

Put `tex/latex/gyoudori/gyoudori.sty` into your TEXMF tree.

## Usage

```tex
\usepackage[displaymath,float]{gyoudori}

\begin{gyoudori}[c]{3}  % position t|c|b (default c), number of lines
A heading
\end{gyoudori}

\gyoudoriarea[b]{2}{A heading}

{\small
Text in \small.
\begin{gyoudori}[b,local]{2}  % local: use the current size and \baselineskip
A heading
\end{gyoudori}
More text in \small stays on its own line grid.\par}
```

The optional argument of the `gyoudori` environment and `\gyoudoriarea` is a
comma-separated list of a position (`t`, `c`, `b`), `local`, and `indent` or
`noindent`. Without `local`, the line pitch of `\normalsize` is used regardless
of the font size. The content is not indented unless `indent` is given.

Package options (key-value):

| key | value | default | meaning |
|---|---|---|---|
| `displaymath` | true/false | false | gyou-dori for display math |
| `float` | true/false | false | gyou-dori for floats |
| `overflow` | warning/error | warning | when the content does not fit in the area |
| `indent` | true/false | false | indent the content of `gyoudori` / `\gyoudoriarea` |
| `floatsep`, `textfloatsep`, `intextsep`, `dblfloatsep`, `dbltextfloatsep` | length | class value | set the length |

## Documentation

- `doc/gyoudori/gyoudori-en.pdf` (English)
- `doc/gyoudori/gyoudori-ja.pdf` (Japanese)

The manuals explain gyou-dori with figures, the usage, the relation to JLREQ,
how it works, and the limitations. Build them with `make doc`
(pLaTeX and dvipdfmx).

## 日本語の概要

`gyoudori`は，見出し・ディスプレイ数式・フロートを行取り（行ドリ）で配置し，
前後の本文の行を基本版面の行位置からずらさないためのパッケージである．
𝑛行取りの領域は「字の枠の高さ × 𝑛 + 行間 × (𝑛 − 1)」で，このパッケージは
既定で内容を領域の中央に置き，位置の指定で上寄せ・下寄せにもできる（領域の定義は
JLREQ §4.1.6）．pLaTeX，upLaTeX，LuaLaTeX（LuaTeX-ja）で動く．このパッケージは横組用である．
詳しくは日本語のマニュアル`doc/gyoudori/gyoudori-ja.pdf`を参照のこと．
