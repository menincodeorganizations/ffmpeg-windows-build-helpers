#!/bin/bash

# docker actually runs this as a script after having copied it in as part of the "big initial copy" making the image...

set -e

OUTPUTDIR=/output

./cross_compile_ffmpeg.sh --build-ffmpeg-shared=y --build-ffmpeg-static=y --disable-nonfree=n --build-intel-qsv=y --compiler-flavors=win64 --enable-gpl=y

./cross_compile_ffmpeg.sh --build-ffmpeg-shared=y --build-ffmpeg-static=y --disable-nonfree=n --build-intel-qsv=y --compiler-flavors=win32 --enable-gpl=y


mkdir -p $OUTPUTDIR/static/bin

mkdir -p $OUTPUTDIR/shared
cp -R -f ./sandbox/ $OUTPUTDIR/shared

if [[ -f /tmp/loop ]]; then
  echo 'sleeping forever so you can attach to this docker if desired' # without this if there's a build failure the docker exits and can't get in to tweak stuff??? :|
  sleep
fi
