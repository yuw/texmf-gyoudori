# CTANの申込書の下書き

CTANのアップロードの申込書（https://ctan.org/upload）に書く内容の下書き．
申込書の欄はすべて英語で書く（「Announcement」と「Administrative notes」も英語）．
このファイルはCTANの配布物には入れない（`tools/ctan/mkctan.sh`が除く）．

版番号・日付・作者名はリリースまで固定する（v20261026.0，2026/10/26，Yuwsuke Kieda）．
連絡先（メールアドレス）は公開しないので，このファイルにも配布物にも書かず，申込書の「Your email」の欄にだけ入力する．

## Package information

| 欄 | 内容 |
|---|---|
| Name of your contribution | `gyoudori`（CTANで未使用であることを2026-10-27に確かめた） |
| Version | 20261026.0（`gyoudori.sty`の`\ProvidesPackage`の`v20261026.0`，READMEの版と同じ．`tools/ctan/mkctan.sh`が一致を確かめる） |
| Maintainer | Yuwsuke Kieda |
| Your email | （申込書にだけ入力する．CTANは公開しない） |
| Summary | Gyou-dori (line-based placement) of headings, display math and floats for Japanese typesetting |
| Suggested CTAN directory | `/macros/latex/contrib/gyoudori` |
| License type | MIT License |
| Topics（申込書にはないが，Descriptionの参考） | `japanese`，`layout`，`headings`，`float`，`maths`，`japanese-doc`（英語の説明書もある） |

### Description

```text
The package implements gyou-dori (line-based placement), a layout used in
Japanese typesetting when the lines of the main text are to stay on a line
grid: an element whose size differs from the main text is placed in an area of
a whole number of lines, so that the following lines stay on the grid.

The gyoudori environment and the \gyoudoriarea command place headings and the
like in an n-line area (top, center or bottom), positioned by the character
frames of the content. Options place display math (equation, \[ \], eqnarray
and the amsmath environments) and floats in such areas automatically, and round
the float separations to whole lines. It works with nidanfloat, stfloats,
flushend and evenend.

Works with pLaTeX, upLaTeX and LuaLaTeX (LuaTeX-ja) for horizontal writing. The
documentation is in English and Japanese.
```

### Announcement（新しいパッケージなので書く）

```text
gyoudori implements gyou-dori (line-based placement) for Japanese typesetting:
headings, display math and floats are placed in areas of a whole number of
lines, so that the lines of the main text stay on the line grid. It works with
pLaTeX, upLaTeX and LuaLaTeX (LuaTeX-ja). The documentation is in English and
Japanese.
```

### Administrative notes

```text
- The package is a single style file (tex/gyoudori.sty) with manuals in English
  and Japanese (doc/, PDF and sources). The manual sources are typeset with
  pLaTeX and dvipdfmx; doc/gyoudori-fig.tex draws the figures with TikZ.
- The package, the documentation and the sources are under the MIT License
  (LICENSE).
```

## Communication channel URLs

いずれも任意．リポジトリは2026-10-26に作り直して公開した（GitHubのIssuesも有効）．

| 欄 | 内容 |
|---|---|
| Home page | （空欄） |
| Bug tracker | https://github.com/yuw/texmf-gyoudori/issues |
| Repository | https://github.com/yuw/texmf-gyoudori |

## 出す前に確かめること

1. 版番号・日付・作者名がsty，README，説明書でそろっていることを確かめる（`tools/ctan/mkctan.sh`が確かめる）．
2. `tools/ctan/mkctan.sh`でアーカイブ`build/ctan/gyoudori.zip`を作る（説明書のPDFはソースから組み直して入れる）．
3. アーカイブを展開して中身を見る．`build/ctan/gyoudori.tds.zip`（配布物には入れない，テスト用のTDSの形のもの）を空のTEXMFツリーに展開し，pLaTeX，upLaTeX，LuaLaTeXで組めるか確かめる．
