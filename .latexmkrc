#!/usr/bin/perl
$latex = 'platex -kanji=utf8 -guess-input-enc -interaction=nonstopmode %O %S';
$bibtex = 'pbibtex -kanji=utf8 %O %B';
$dvipdf = 'dvipdfmx -p a4 -f ms.map -z 0 %O %S';
$pdf_mode = 3;
$pdf_previewer = 'open -a Preview';
