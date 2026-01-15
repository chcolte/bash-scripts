#!/bin/bash


# forループを使ってダウンロードするURLを連結していきます。
urls=""
for ((i=${1}; i<=${2}; i++)); do
  urls="${urls} https://pokemonbbs.com/post/read.cgi?no=${i}"
done

# 3. wgetコマンドの実行
wget -E -H -k -K -p -e robots=off --domains=img.pokemonbbs.com,pokemonbbs.com --user-agent="Mozilla/5.0" $urls --wait=0.1 --random-wait


