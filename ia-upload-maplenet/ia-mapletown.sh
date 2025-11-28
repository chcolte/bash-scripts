#!/bin/bash
# REMOVE SECRET KEY!

source secret.env

b=68
poststart=1
postend=5

echo ${b}

# ref: https://foxrow.com/til-api-for-saving-webpages-in-the-wayback-machine
# save posts
for ((i=${poststart} ; i<=${postend} ; i++))
do
  curl -X POST -H "Accept: application/json" -H "Authorization: LOW ${IA_ACCESS_KEY}:${IA_SECRET_KEY}" -d"url=https://maple:patty@www.maple.town/bbs/${b}/${i}&capture_all=1&skip_first_archive=1&delay_wb_availability=1&email_result=1&target_username=maple&target_password=patty" "https://web.archive.org/save"
  echo "\n"
  sleep 10
  # waybackmachineのsavenowは1minに15requestまで? sleep 6だとrate limitにかかる　もしかすると1分あたり以外にも制限があるかも
  # limitで途中から受け付けられないことを避けることを優先した値
done

read -p "saved posts! next: save list page "

# save lists
pages=0
for ((i=0 ; i<${pages} ; i++))
do
  start=$((i * 50))
  end=$(((i + 1) * 50 - 1))
  
  #echo "url=https://maple:patty@www.maple.town/bbs/l/${start}-${end}"
  curl -X POST -H "Accept: application/json" -H "Authorization: LOW ${IA_ACCESS_KEY}:${IA_SECRET_KEY}" -d"url=https://maple:patty@www.maple.town/bbs/${b}/l/${start}-${end}&capture_all=1&delay_wb_availability=1&skip_first_archive=1&wm-save-mywebarchive=1&wacz=1" "https://web.archive.org/save"
  echo "\n"
  sleep 10
done
