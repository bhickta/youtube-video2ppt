#!/bin/sh

clean () {
    sed -i '/./d' ids.txt final_urls.txt
}

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
        (echo $url; echo ./Output; echo 5) | bash vid2ppt.sh
    done
}


clean
    echo "Sucessfully cleaned urls.txt"
extract_playlist_ids
    echo "Successfully generated ids"
ids_to_urls
    echo "Successfully generated urls"
remove_playlist_urls
    echo "Successfully removed playlist urls"
vid2ppt
    Successfully