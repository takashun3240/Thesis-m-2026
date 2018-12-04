#!/bin/bash

# mytex.sh
# author: Haruyuki Ichino
# 2015/08/18
# (updated by: Kenta Urano at 2018/12/03
# auto compiling script tex file
# Usage:
#   $ mytex.sh param1 param2
#       param1 - file name (usually thesis.tex )
#       param1 - update index option (notice: this will be ignored!)
#   Example) $ mytex.sh thesis.tex -b
# ---------------------------------------------------------




err_pro(){
    if [ ! -e $1 ]; then
        echo "Not found: $1"
        echo "You need to set $1 on correct directory"
        exit 1
    fi
}

# check arguments
if [ $# -eq 0 ]; then
  echo "Filename not provided"
  exit 1
fi

cmdname=`basename $0`
basename=${1##*/}
filename=${basename%.*}
extension=${basename##*.}

if [ $# -eq 1 -a "${extension}" = "tex" ]; then
    err_pro $basename
fi

# # -b option
# while getopts b: OPT
# do
#   case $OPT in
#     "b")
#         basename=${OPTARG##*/}
#         filename=${basename%.*}
#         err_pro $basename
#         platex -shell-escape $filename.tex
#         pbibtex $filename.aux
#         platex $filename.tex
#         ;;
#     *)
#         echo "Usage: ${cmdname} [-b] filename"
#         exit 1
#         ;;
#   esac
# done


platex $filename.tex
pbibtex $filename.aux
platex $filename.tex
platex $filename.tex

dvipdfmx $filename.dvi
# open $filename.tex
open $filename.pdf
