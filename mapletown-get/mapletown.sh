#!/bin/bash

#curl -L -R --create-dirs -o bbs/${1}/#1.html "https://maple:patty@www.maple.town/bbs/${1}/[${2}-${3}].html" -u maple:patty --limit-rate 1K

# 1. 保存先ディレクトリを作成
mkdir -p "bbs/${1}"

# 2. URLリストを生成
# 変数を含むブレース展開が失敗する環境に対応するため、
# forループを使ってダウンロードするURLを連結していきます。
urls=""
for ((i=${2}; i<=${3}; i++)); do
  urls="${urls} https://www.maple.town/bbs/${1}/${i}.html"
done

# 3. wgetコマンドの実行
# 生成したURLリスト($urls)を引数として渡します。
# これにより、wgetはリスト内の各ファイルを処理する合間に1秒待機(--wait=1)します。
wget \
  --user=maple \
  --password=patty \
  --wait=1 \
  -P "bbs/${1}" \
  $urls

  
