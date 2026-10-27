#!/bin/sh
# CTANに出すアーカイブを作る．
#   build/ctan/gyoudori.zip（展開するとgyoudori/．CTANに出すのはこれだけ）
#   build/ctan/gyoudori.tds.zip（同じファイルをTDSの形に並べたもの．空のTEXMFに入れて組むテスト用で，
#     CTANには出さない）
# READMEはこのリポジトリのREADME.md，README-ja.mdではなく，CTAN用のctan/README.md，
# ctan/README-ja.mdを入れる．説明書のPDFはgitに登録していないので，ソースから組み直して入れる．
# 使い方：sh tools/ctan/mkctan.sh
#   版番号や日付が食い違う，などの問題があれば止まる．
#   platexとdvipdfmxはPATHから探す（例：PATH=/usr/local/texlive/2026/bin/universal-darwin:$PATH）．
# 中身はgitに登録したファイルだけから作る．配る範囲にgitに登録していないファイルがあれば止まる
# （置いたままのメモや下書きを配らないため．配るならgit addしてから作る）．
set -e
root=$(cd "$(dirname "$0")/../.." && pwd)
cd "$root"
out="$root/build/ctan"
stage="$out/stage"
rm -rf "$stage" "$out/gyoudori.zip" "$out/gyoudori.tds.zip"
mkdir -p "$stage/gyoudori" "$stage/tds" "$stage/docbuild"
pkg="$stage/gyoudori"
tds="$stage/tds"

fail() { echo "mkctan: $*" >&2; exit 1; }

# 1. 版番号と日付（gyoudori.styの\ProvidesPackageが基準）
provides=$(sed -n 's/^ *\[\([0-9/]*\) v\([0-9.]*\) style file.*/\1 \2/p' tex/latex/gyoudori/gyoudori.sty)
date=${provides% *}; ver=${provides#* }
[ -n "$date" ] && [ -n "$ver" ] || fail "cannot read \\ProvidesPackage"
isodate=$(echo "$date" | tr / -)
jdate=$(echo "$date" | awk -F/ '{printf "%d年%d月%d日", $1, $2, $3}')
grep -q "^- Version: v$ver ($isodate)$" README.md || fail "README.md: version/date is not 'v$ver ($isodate)'"
grep -q "^- 版：v$ver（$isodate）$" README-ja.md || fail "README-ja.md: version/date is not 'v$ver（$isodate）'"
grep -q "^Version $ver, $isodate\.$" ctan/README.md || fail "ctan/README.md: version/date is not 'Version $ver, $isodate.'"
grep -q "^版$ver，$jdate．$" ctan/README-ja.md || fail "ctan/README-ja.md: version/date is not '版$ver，$jdate．'"
grep -q "\\\\date{$jdate\\\\quad v$ver}" doc/gyoudori/gyoudori-ja.tex || fail "gyoudori-ja.tex: \\date is not '$jdate\\quad v$ver'"
grep -q "\\\\date{$isodate\\\\quad v$ver}" doc/gyoudori/gyoudori-en.tex || fail "gyoudori-en.tex: \\date is not '$isodate\\quad v$ver'"
echo "version $ver, $isodate"

# 2. 配る対象のファイル（gitに登録したもの）
#    このリポジトリのREADME，Makefile，tools/，申込書の下書きは除く
pick() {
  while read -r f; do [ -f "$f" ] && echo "$f"; done \
  | grep -v -e '^\.' -e '/\.' -e '^build/' -e '^tools/' -e '^Makefile$' \
           -e '^README\.md$' -e '^README-ja\.md$' -e '^ctan/upload-form\.md$' || true
}
untracked=$(git ls-files --others --exclude-standard | pick)
[ -z "$untracked" ] || fail "files not added to git: $(echo $untracked)"
files=$(git ls-files --cached | sort -u | pick)
bad=$(echo "$files" | grep -v -E '^[A-Za-z0-9/._+-]+$' || true)
[ -z "$bad" ] || fail "bad file names: $bad"
# メールアドレスは配布物に書かない
mail=$(echo "$files" | xargs grep -I -n -E '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' 2>/dev/null || true)
[ -z "$mail" ] || fail "e-mail addresses in: $mail"

# 3. 並べる（CTANの展開した形と，TDSの形）
put() { # put 元 先
  mkdir -p "$(dirname "$2")"; cp "$1" "$2"
}
for f in $files; do
  case "$f" in
    tex/latex/gyoudori/*)              put "$f" "$pkg/tex/${f##*/}";         put "$f" "$tds/$f" ;;
    doc/gyoudori/*)                    put "$f" "$pkg/doc/${f##*/}";         put "$f" "$tds/doc/latex/gyoudori/${f##*/}" ;;
    ctan/README.md|ctan/README-ja.md)  put "$f" "$pkg/${f#ctan/}";           put "$f" "$tds/doc/latex/gyoudori/${f#ctan/}" ;;
    LICENSE)                           put "$f" "$pkg/$f";                   put "$f" "$tds/doc/latex/gyoudori/$f" ;;
    *) fail "no place for $f" ;;
  esac
done

# 4. 説明書のPDFを，並べたソースとstyだけで組む（TEXINPUTSでこのstyを先に見せる）
command -v platex >/dev/null && command -v dvipdfmx >/dev/null || fail "platex/dvipdfmx not found in PATH"
cp "$pkg"/doc/*.tex "$stage/docbuild/"
(
  cd "$stage/docbuild"
  for d in gyoudori-ja gyoudori-en; do
    TEXINPUTS="$pkg/tex//:" platex -interaction=nonstopmode -halt-on-error "$d" >/dev/null 2>&1 || fail "platex $d (1)"
    TEXINPUTS="$pkg/tex//:" platex -interaction=nonstopmode -halt-on-error "$d" >/dev/null 2>&1 || fail "platex $d (2)"
    grep -q "Package: gyoudori $date v$ver" "$d.log" || fail "$d: not typeset with gyoudori v$ver"
    w=$(grep -c -e 'undefined' -e 'may have changed' -e '^Overfull' "$d.log" || true)
    [ "$w" = 0 ] || fail "$d: $w warnings (undefined references or Overfull)"
    dvipdfmx -q "$d" >/dev/null 2>&1 || fail "dvipdfmx $d"
    put "$d.pdf" "$pkg/doc/$d.pdf"; put "$d.pdf" "$tds/doc/latex/gyoudori/$d.pdf"
  done
)

# 5. 検査：ファイル名，改行コード，説明書のPDF
cd "$stage"
bad=$(find gyoudori tds | grep -v -E '^[A-Za-z0-9/._+-]+$' || true)
[ -z "$bad" ] || fail "bad file names: $bad"
crlf=$(find gyoudori -type f \( -name '*.tex' -o -name '*.sty' -o -name '*.md' \) -exec grep -l "$(printf '\r')" {} + || true)
[ -z "$crlf" ] || fail "CRLF line endings: $crlf"
for p in gyoudori-ja.pdf gyoudori-en.pdf; do
  [ -f "gyoudori/doc/$p" ] || fail "missing doc/$p"
done

# 6. パーミッション：ディレクトリは755，ファイルは644
find gyoudori tds -type d -exec chmod 755 {} +
find gyoudori tds -type f -exec chmod 644 {} +

# 7. まとめる
(cd tds && zip -q -r -X "$out/gyoudori.tds.zip" tex doc)
zip -q -r -X "$out/gyoudori.zip" gyoudori
cd "$root"
echo "$out/gyoudori.zip: $(unzip -l "$out/gyoudori.zip" | tail -1 | awk '{print $2}') files (for CTAN)"
echo "$out/gyoudori.tds.zip: $(unzip -l "$out/gyoudori.tds.zip" | tail -1 | awk '{print $2}') files (for tests only)"
