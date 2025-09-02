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

echo "Starting..." > "$STATUS_FILE"
INPUT_FILE=$(ls "$INPUT_DIR/"*.wav | head -n 1)
INPUT_TEXT=$(ls "$INPUT_DIR/"*.txt | head -n 1)

if speech2textalign --filename "$INPUT_FILE" --align "$INPUT_TEXT"; then
    mv *.tsv "$OUTPUT_DIR"
    mv *.html "$OUTPUT_DIR"
    echo "Done." > "$STATUS_FILE"
    exit 0
else
    mv *.tsv "$OUTPUT_DIR"
    mv *.html "$OUTPUT_DIR"
    echo "Failed." > "$STATUS_FILE"
    exit 1
fi
