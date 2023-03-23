#!/bin/bash

set -e

if ! command -v wget &> /dev/null || ! command -v xz &> /dev/null
then
    echo "Ensure you have installed the following commands: wget, xz"
    exit
fi

wget -nc https://archive.org/download/arabic_corpus/arabic_corpus.xz -P $( dirname -- "$0"; )
xz -d $( dirname -- "$0"; )/arabic_corpus.xz
