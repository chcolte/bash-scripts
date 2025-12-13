#!/bin/bash
source secret.env

INPUT_FILE="$1"
LOG_FILE="log.txt"
while IFS= read -r target_url || [ -n "$target_url" ]; do
    
    # 空行やコメント（#で始まる行）をスキップ
    if [[ -z "$target_url" || "$target_url" =~ ^# ]]; then
        continue
    fi
    echo "Saving: $target_url"

    # 指定されたcurlコマンドの実行
    # -s: 進行状況バーを非表示 (結果のJSONのみ表示したい場合)
    {
    curl -X POST -s \
         -H "Accept: application/json" \
         -H "Authorization: LOW ${IA_ACCESS_KEY}:${IA_SECRET_KEY}" \
         -d "url=${target_url}&capture_all=1&skip_first_archive=1&delay_wb_availability=1&email_result=1" \
         "https://web.archive.org/save"
    } | tee -a "$LOG_FILE" # 画面に出しつつファイルに追記
    
    sleep 15

done < "$INPUT_FILE"

echo "all url requested: $INPUT_FILE"
