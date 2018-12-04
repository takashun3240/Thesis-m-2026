# 計算理工時代の修論テンプレファイル〜〜〜！！！

## 概要

長らく先輩から引き継がれてきた修論テンプレに`icchi`さんが変更を加えたものを，`vrano`が弄ってできたオレオレ修論テンプレです．

ちょっとしたtips的なものを含めて各章を適当に作ってあります．

フォークして使ってね！

## ファイル構成

このファイルが存在するディレクトリを`<root>`として，次の構造になっています．

```tree
<root>
├── README.md : このファイル
├── chap : 各章のファイルおよびappendix用のファイル
│   ├── appendix.tex
│   ├── chapter1.tex
│   ├── chapter2.tex
│   ├── chapter3.tex
│   ├── chapter4.tex
│   ├── chapter5.tex
│   └── chapter6.tex
├── here.sty : thesis.tex内で読み込んでいるパッケージその1
├── images : 本文で参照する画像
│   └── dummy.png
├── jlisting.sty : thesis.tex内で読み込んでいるパッケージその2
├── multirow.sty : thesis.tex内で読み込んでいるパッケージその3
├── mytex.sh : コンパイル用スクリプト(for mac)
├── notice : tex以外の関連文書
│   ├── 2-4 H29修士論文要旨体裁.doc
│   └── 表紙_vrano.docx
├── ref.bib : bibtexのファイル
├── thesis.pdf : コンパイル済み論文(礼)
├── thesis.tex : 論文メインファイル
└── url.sty : thesis.tex内で読み込んでいるパッケージその4
```

`*.sty`については使わない場合削除して構いません．

## コンパイルについて

ファイル群に`mytex.sh`が入っています．以下のようにターミナルで実行すると`platex`→`pbibtex`→`platex`→`platex`と実行されるはずです，

```bash
# at the project root
$ ./mytex.sh thesis.tex
```

## VSCode用のおまけ

`latex-workshop`パッケージ用の自動コンパイル設定(ただし修論が長くなってくるとめちゃくちゃコンパイルに時間がかかるので使用は推奨しない)．

日本語書いててバックスペース文字でエラーする場合は`kill-bs-char`でビルドするようにすると吉．

```json
    // for building latex automatically
    "latex-workshop.latex.tools": [
        {
            "command": "extractbb",
            "args": [
                "figs/*.png"
            ],
            "name": "extractbb"
        },
        {
            "command": "platex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-jobname=\"%DOCFILE%\"",
                "-kanji=utf8",
                "-guess-input-enc",
                "%DOC%"
            ],
            "name": "platex"
        },
        {
            "command": "pbibtex",
            "args": [
                "-kanji=utf8",
                "%DOCFILE%"
            ],
            "name": "pbibtex"
        },
        {
            "command": "dvipdfmx",
            "args": [
                "%DOCFILE%.dvi"
            ],
            "name": "dvipdfmx"
        },
        {
            "command": "gawk",
            "args": [
                "-i",
                "inplace",
                "-v",
                "INPLACE_SUFFIX=.bak",
                "{gsub(\"\\\\b\",\"\",$0);print $0}",
                "%DOC%.tex"
            ],
            "name": "awk"
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "kill-bs-char",
            "tools": [
                "awk",
                "extractbb",
                "platex",
                "pbibtex",
                "platex",
                "platex",
                "dvipdfmx"
            ]
        },
        {
            "name": "with bibtex",
            "tools": [
                "extractbb",
                "platex",
                "pbibtex",
                "platex",
                "platex",
                "dvipdfmx"
            ]
        },
        {
            "name": "no-extract-bb",
            "tools": [
                "platex",
                "pbibtex",
                "platex",
                "platex",
                "dvipdfmx"
            ]
        },
        {
            "name": "without bibtex",
            "tools": [
                "extractbb",
                "platex",
                "platex",
                "dvipdfmx"
            ]
        },
    ],
    "latex-workshop.latex.clean.enabled": true,
    "latex-workshop.view.pdf.viewer": "tab"
```