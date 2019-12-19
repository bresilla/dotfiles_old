#!/bin/sh
[[ ! -d "/opt/conda/bin" ]] && exit
PATH="/opt/conda/bin:$PATH"
conda create -n "$(basename $PWD)" python=3.7
