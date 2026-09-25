# Gyou-dori

## Author

Yuwsuke Kieda

## Date

2020-07-31

## Version

0.1

## License

MIT

## Abstract

We offer one way of realizing the gyou-dori.

gyou-dori >>> https://www.w3.org/TR/jlreq/#processing_of_gyoudori

## Requirement

(u)pLaTeX with e-

## Usage

The following two codes have the same effect.

```tex
\begin{gyoudori}[#1]{#2}
#3
\end{gyoudori}
```

```tex
\gyoudoriarea[#1]{#2}{#3}
```

If no blank line follows `\end{gyoudori}`, the next paragraph is not indented
(and no `\parskip` is inserted), as after a display math.
The same applies to the display math environments with the `displaymath` option.

### Arguments (option): #1

The heading text postions.

- t: top in the area
- c: center in the area (default)
- b: bottom in the area

### Arguments: #2

The line numbers of the area.

### Arguments: #3

The heading text.

## Package option

### displaymath=true|false

Automatically apply gyou-dori to the display math environments
`eqnarray`, `eqnarray*`, `align`, `align*`, `gather` and `gather*`
(`align` and `gather` require amsmath).
Each display is centered in the smallest area of at least 2 lines that holds it.
The default is `false`.

```tex
\usepackage[displaymath=true]{gyoudori}
```

### float=true|false

Place floats on the line grid.
Each float is put in the smallest gyou-dori area (at least 1 line) that holds it,
and aligned to the top (`t`) when placed at the top of a page,
to the bottom (`b`) when placed at the bottom,
and centered when placed here (`h`).
The separations below are rounded up to
"the interline gap + a multiple of the baselineskip" without stretch or shrink,
so that the text lines around floats stay on the grid.
Float-only pages are not handled.
With the nidanfloat package, double-column floats (`figure*`) are aligned
to the top of the page (`t`) or to the last line of the page (`b`),
and single-column bottom floats in two-column mode are aligned to the last line
of the column.
With the flushend package, the balanced columns of the last page keep the line grid:
the glue in the columns is not stretched or shrunk
(so the `spread`/`shrink` options have no effect),
and the gap where the two columns are joined is rounded up to the line grid.
The default is `false`.

### floatsep, textfloatsep, intextsep, dblfloatsep, dbltextfloatsep

Set the corresponding lengths.
If not given, the values of the document class are used.

```tex
\usepackage[float=true,textfloatsep=2\baselineskip,intextsep=10pt]{gyoudori}
```

## Repository

https://github.com/yuw/texmf-gyoudori
