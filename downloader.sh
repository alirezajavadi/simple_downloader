#!/bin/bash
display_help() {
    echo "Simple Downloader Script."
    echo " Usage: $0 -l YOUR_LINKS_PATH [-s SLEEP_TIME_IN_SECOND]"
    echo
    echo "	-s  Waiting time (Seconds) before the first download."
    echo
    echo " Example:"
    echo " 	$0 -l links.txt -s 480"
    echo " 	This will be download all file inside links.txt file after 480 Seconds (8 Minutes)."
    exit 1
}

while getopts s:l: flag
do
    case "${flag}" in
        s) sleepp=${OPTARG};;
        l) links=${OPTARG};;
    esac
done

if [[ $links == "" ]]
then
  display_help
fi

if [ ! -f $links ] 
then
    echo "[!] File '$links' is not exists." 
    exit 1
fi

if [[ $sleepp == "" ]]; then
  sleepp=0 
fi


SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)


items=$(wc -l < $links)
if [[ $items == 0 ]]; then
  echo "[!] $links Is Empty!"
  exit 1
fi

echo "[+] $items item(s) will be download after $sleepp Sec."

if [[ ! -d $SCRIPT_DIR/Download ]]; then
  mkdir $SCRIPT_DIR/Download
fi

sleep $sleepp

wget -i $links -q --show-progress -P $SCRIPT_DIR/Download
