#!/bin/sh

extract_playlist_ids () {
    for url in $(cat urls.txt)
    do
        youtube-dl --get-id $url >> ids.txt
    done
}

ids_to_urls () {
    for id in $(cat ids.txt)
    do
        echo https://www.youtube.com/watch?v=$id >> final_urls.txt
    done
}

remove_playlist_urls () {
    sed -i '/?list/d' urls.txt
}

vid2ppt () {
    for url in $(cat final_urls.txt)
    do
        (echo $url; echo ./Output; echo 5) | bash y2ppt/vid2ppt.sh
    done
}

remove_video_ppt () {
    rm Output/*/*.mp4 Output/*/*.pptx
}

remove_duplicates () {
   echo "y" | python ../difPy/dif.py -A "Output" -s "low" -d "true"
}

remove_dupli_outputs () {
    rm *txt *.json
}
extract_playlist_ids
ids_to_urls
remove_playlist_urls
vid2ppt
remove_video_ppt
remove_duplicates
remove_dupli_outputs