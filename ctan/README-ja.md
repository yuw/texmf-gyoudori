# gyoudori（日本語のREADME）

英語版は`README.md`を参照のこと．

版20261026.0，2026年10月26日．
作者：木枝祐介

見出し・ディスプレイ数式・フロートを行取り（行ドリ）で配置し，前後の本文の行を行のグリッドからずらさないためのLaTeXパッケージである．

## 概要

*行取り*（行ドリ）とは恣意的なレイアウトのひとつで，見出しのように本文と大きさの違う要素が行送り方向に占める領域を基本版面の何行分かとして決め，その後ろの本文の行を基本版面で決めた行の位置（行のグリッド）からずらさないようにする方法である．行取りは日本語の書籍などの組版で，各ページの本文の行を行のグリッドにそろえて配置するよう指定されたときに用いられる．このパッケージはそうした指定のもとで組版しなければならない場合のための道具である．

𝑛行取りの領域の行送り方向の大きさは

    字の枠の高さ × 𝑛 + 行間 × (𝑛 − 1)
      = 行送り × (𝑛 − 1) + 字の枠の高さ

である（JLREQ（W3C『日本語組版処理の要件』）§4.1.6）．

- `gyoudori`環境と`\gyoudoriarea`命令は，内容を𝑛行取りの領域に置く（上寄せ・中央・下寄せ）．内容は字の枠で位置を決める．`local`をつけると，その場の文字サイズと`\baselineskip`を基準にするので，`\small`などのなかでも使える．内容が領域に収まらないときは警告（またはエラー）を出す．
- オプション`displaymath`：ディスプレイ数式（`equation`，`\[ \]`，`eqnarray`と，amsmathの`equation*`，`align`，`gather`，`multline`，`flalign`，`alignat`，およびそれぞれの`*`つき）を，数式が要する行数に1行を足した行数（2行以上．`displaymathextra`で変えられる）で行取りし，ベースラインで中央に置く．その場の文字サイズと`\baselineskip`を基準にするので，脚注や`\small`で組んだ部分のなかの数式も，まわりの行送りにそろう．
- オプション`float`：フロートを最少の行数の行取りの領域にし，行のグリッドにそろえる．フロートまわりのアキは行送りの単位に丸める．フロートだけのページもグリッドにそろえる．nidanfloat，stfloats，flushend，evenendと併用できる．

## 使い方

```latex
\usepackage[displaymath,float]{gyoudori}

\begin{gyoudori}[c]{3}  % 位置t|c|b（既定はc），行数
見出し
\end{gyoudori}

\gyoudoriarea[b]{2}{見出し}
```

`gyoudori`環境と`\gyoudoriarea`のオプション引数には，位置（`t`，`c`，`b`），`local`，`indent`または`noindent`をカンマで区切って指定する．

| パッケージオプション | 値 | 既定 | 意味 |
|---|---|---|---|
| `displaymath` | true/false | false | ディスプレイ数式を行取りする |
| `displaymathextra` | 0以上の整数 | 1 | 数式が要する行数に足す行数 |
| `float` | true/false | false | フロートを行取りする |
| `overflow` | warning/error | warning | 内容が領域に収まらないときの扱い |
| `indent` | true/false | false | `gyoudori`・`\gyoudoriarea`の内容を字下げする |
| `floatsep`，`textfloatsep`，`intextsep`，`dblfloatsep`，`dbltextfloatsep` | 長さ | クラスの値 | 同名の長さを設定する |

## 動作要件

- pLaTeX，upLaTeX，またはLuaLaTeX＋LuaTeX-ja（jarticle，ujarticle，ltjsarticle，jlreqなど）．横組用である（縦組は考慮していない．説明書の制限事項を参照）．
- LaTeX 2022-06-01以降．ほかのパッケージは必要ない．
- TeX Live 2025と2026のpLaTeX，upLaTeX，LuaLaTeXで動作を確かめた．

## 説明書

説明書は日本語版と英語版があり，内容は同じである．行取りを図で説明し，使い方，JLREQとの関係，仕組み，制限事項を述べる．

- `doc/gyoudori-ja.pdf`，`doc/gyoudori-en.pdf`：説明書．
- `doc/gyoudori-ja.tex`，`doc/gyoudori-en.tex`，`doc/gyoudori-fig.tex`：説明書のソース（pLaTeXとdvipdfmxで組む．`gyoudori-fig.tex`は図を描き，TikZを使う）．

## インストール

TEXMFツリーの次の場所に配置する．

| ファイル | 置き場所 |
|---|---|
| `tex/gyoudori.sty` | `tex/latex/gyoudori/` |
| `doc/*`，`README.md`，`README-ja.md`，`LICENSE` | `doc/latex/gyoudori/` |

## ライセンス

MITライセンス（`LICENSE`）．
