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

remove_video () {
    rm Output/*/*.mp4
}

remove_duplicates () {
   echo "y" | python difPy/dif.py -A "Output" -s "low" -d "true"
}

remove_dupli_outputs () {
    rm *.txt *.json
}
extract_playlist_ids
    echo "Success"
ids_to_urls
    echo "Success"
remove_playlist_urls
    echo "Success"
vid2ppt
    echo "Success"
remove_duplicates
    echo "Success"
remove_video
remove_dupli_outputs