#!/bin/bash


# makes mp3 versions of a folder full of wav files. 
# dumps mp3 files into a subfolder called em-pee-three


d="$1"

echo "checking for flac files in $d"


convert_wav () {
	echo "Converting Flac files"
	echo " ~> making em-pee-three/ dir"
	mkdir "${d}/em-pee-three"
	for f in "${d}"/*.wav; do
		base="${f##*/}"
		base_f="${base%.*}"
		echo " ---> converting ${f} to ${d}/em-pee-three/${base_f}.mp3"
		ffmpeg -i "${f}" -ab 320k -map_metadata 0 -id3v2_version 3 "${d}/em-pee-three/${base_f}.mp3"
	done
}

iswav=0

for f in "${d}"/* ; do
	echo "${f}"
	if [[ "${f}" == *.wav ]] ; then
		echo "is wav"
		iswav=1
		break
	else
		echo "not wav"
 	fi
done

if [ $iswav == 1 ] ; then
	echo " +++ Wav files found"
	convert_wav
else
	echo " --- No wav files found"
fi



