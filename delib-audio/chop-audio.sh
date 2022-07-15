#!/bin/bash
#Due to a bug ffmpeg will not work with an array created from a text file
start_timestamps=(00:01:02 00:01:33 00:02:00 00:02:15 00:00:45 00:00:25
 00:01:36 00:02:00 00:02:10 00:05:55 00:06:23 00:08:10 00:00:00 00:00:55
 00:01:35 00:01:40 00:02:35 00:03:55)
duration=8

#Iterate through each audio file and cut them first into MP4 video clips
#and then convert to WAV audio files.
counter=0
for f in delib-audio/full-audio/*;
do
    filename=$(echo $f | sed "s:.*/::")
    start_ts_i=${start_timestamps[$counter]}
    ffmpeg -i "$f" -ss $start_ts_i -t $duration -c copy delib-audio/cuts/"$filename"_CUT.mp4
    ffmpeg -i delib-audio/cuts/"$filename"_CUT.mp4 -ac 1 -ar 16000 -acodec pcm_s16le -f wav delib-audio/cuts/"$filename"_CUT.wav
    rm delib-audio/cuts/"$filename"_CUT.mp4
    counter=$(($counter + 1))
done
read wait
