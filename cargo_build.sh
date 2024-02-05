#!/bin/sh
docker run --rm -v ${PWD}:/home/builder/app -it rust_cross_compile/aarch64
