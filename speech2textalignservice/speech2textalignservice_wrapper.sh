#!/bin/sh

export CUDA_VISIBLE_DEVICES=0

STATUS_FILE=$1
shift
INPUT_DIR=$1
shift
OUTPUT_DIR=$1
shift

if [ -z "$STATUS_FILE" ] || [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "One or more positional arguments are missing">&2
    exit 1
fi
if [ -z "$HF_TOKEN" ]; then
    echo "HF_TOKEN not set">&2
    exit 1
fi

while getopts "l:p:" arg; do
    case $arg in
        l)
            #for future use
            TARGETLANG=$OPTARG
            ;;
        *)
            echo "Invalid option">&2
            exit 1
            ;;
    esac
done

echo "Starting..." > "$STATUS_FILE"
INPUT_FILE=$(ls "$INPUT_DIR/*.wav" | head -n 1)
INPUT_TEXT=$(ls "$INPUT_DIR/*.txt" | head -n 1)

if speech2textalign --filename "$INPUT_FILE" --align "$INPUT_TEXT"; then
    echo "Done." > "$STATUS_FILE"
    exit 0
else
    echo "Failed." > "$STATUS_FILE"
    exit 1
fi
