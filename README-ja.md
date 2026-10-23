# gyoudori — 行取り（行ドリ）の実現

- 作者：木枝祐介（Yuwsuke Kieda）
- 版：v20261023.1（2026-10-23）
- ライセンス：MIT
- リポジトリ：https://github.com/yuw/texmf-gyoudori

英語版：[README.md](README.md)

## 行取りとは何か

*行取り*（行ドリ）とは恣意的なレイアウトのひとつで，見出しのように本文と大きさの違う
要素が行送り方向に占める領域を基本版面の何行分かとして決め，その後ろの本文の行を基本版面で
決めた行の位置（行のグリッド）からずらさないようにする方法である．行取りは日本語の書籍などの
組版で，各ページの本文の行を行のグリッドにそろえて配置するよう指定されたときに用いられる．
このパッケージはそうした指定のもとで組版しなければならない場合のための道具である．

𝑛行取りの領域の行送り方向の大きさは

    字の枠の高さ × 𝑛 + 行間 × (𝑛 − 1)
      = 行送り × (𝑛 − 1) + 字の枠の高さ

である．このパッケージは既定では内容を領域の中央に置く．位置の指定で上寄せと下寄せに
変えられる．領域の中のどこに置くかは組版の指定によって異なる．
JLREQ（W3C『日本語組版処理の要件』）§2.5.2，§4.1.6を参照のこと：
https://www.w3.org/TR/jlreq/#processing_of_gyoudori

## 機能

- `gyoudori`環境と`\gyoudoriarea`命令は，内容を𝑛行取りの領域に置く（上寄せ・中央・
  下寄せ）．内容は字の枠で位置を決める．`local`をつけると，その場の文字サイズと
  `\baselineskip`を基準にするので，`\small`などのなかでも使える．内容が領域に
  収まらないときは警告（またはエラー）を出す．
- オプション`displaymath`：ディスプレイ数式（`equation`，`\[ \]`，`eqnarray`と，
  amsmathの`equation*`，`align`，`gather`，`multline`，`flalign`，`alignat`，および
  それぞれの`*`つき）を，数式が要する行数に1行を足した行数（2行以上．
  `displaymathextra`で変えられる）で行取りし，ベースラインで中央に置く．式の上下には
  合わせて1行分のアキが加わる．その場の文字サイズと`\baselineskip`を基準にするので，
  脚注や`\small`で組んだ部分のなかの数式も，まわりの行送りにそろう．
- オプション`float`：フロートを最少の行数の行取りの領域にし，行のグリッドにそろえる．
  フロートまわりのアキは行送りの単位に丸める．フロートだけのページもグリッドにそろえる．
  nidanfloat，stfloats，flushend，evenendと併用できる．

## 動作環境

- pLaTeX，upLaTeX，またはLuaLaTeX＋LuaTeX-ja（ltjsarticle，jlreqなど）．
  横組用である（縦組は考慮していない．マニュアルの制限事項を参照）．
- LaTeX 2022-06-01以降（カーネルのkey-value機能を使う）．ほかのパッケージは必要ない．

## インストール

`tex/latex/gyoudori/gyoudori.sty`をTEXMFツリーに置く．

## 使い方

```tex
\usepackage[displaymath,float]{gyoudori}

\begin{gyoudori}[c]{3}  % 位置t|c|b（既定はc），行数
見出し
\end{gyoudori}

\gyoudoriarea[b]{2}{見出し}

{\small
小さい文字で組んだ本文．
\begin{gyoudori}[b,local]{2}  % local：その場の文字サイズと\baselineskipを使う
見出し
\end{gyoudori}
続く本文も，小さい文字の行のグリッドにのる．\par}
```

`gyoudori`環境と`\gyoudoriarea`のオプション引数には，位置（`t`，`c`，`b`），`local`，
`indent`または`noindent`をカンマで区切って指定する．`local`をつけないときは，文字サイズに
よらず`\normalsize`の行送りが基準である．`indent`をつけなければ，内容は字下げしない．

パッケージオプション（key-value形式）：

| キー | 値 | 既定 | 意味 |
|---|---|---|---|
| `displaymath` | true/false | false | ディスプレイ数式を行取りする |
| `displaymathextra` | 0以上の整数 | 1 | 数式が要する行数に足す行数 |
| `float` | true/false | false | フロートを行取りする |
| `overflow` | warning/error | warning | 内容が領域に収まらないときの扱い |
| `indent` | true/false | false | `gyoudori`・`\gyoudoriarea`の内容を字下げする |
| `floatsep`，`textfloatsep`，`intextsep`，`dblfloatsep`，`dbltextfloatsep` | 長さ | クラスの値 | 同名の長さを設定する |

## マニュアル

- `doc/gyoudori/gyoudori-ja.pdf`（日本語）
- `doc/gyoudori/gyoudori-en.pdf`（英語）

マニュアルでは，行取りを図で説明し，使い方，JLREQとの関係，仕組み，制限事項を述べる．
`make doc`で組める（pLaTeXとdvipdfmx）．
