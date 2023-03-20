#!/bin/bash

set -e

if ! command -v wget &> /dev/null || ! command -v xz &> /dev/null
then
    echo "Ensure you have installed the following commands: wget, xz"
    exit
fi

wget https://archive.org/download/arabic_corpus/arabic_corpus.xz
xz -d arabic_corpus.xz
