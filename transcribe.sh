#!/bin/bash
> output.txt
for f in delib-audio/cuts/*; do
  filename=$(echo $f | sed "s:.*/::")
  if [[ $filename == en* ]];
  then
    echo "Transcribing $f..."
    deepspeech --model deepspeech/en/deepspeech-0.9.3-models.pbmm --scorer deepspeech/en/deepspeech-0.9.3-models.scorer --audio $f >> output.txt
  elif [[ $filename == it* ]]
  then
    echo "Transcribing $f..."
    deepspeech --model deepspeech/it/output_graph.pbmm --scorer deepspeech/it/scorer --audio $f >> output.txt
  else
    echo "Invalid Filename: Please indicate the source language with \'en\' or \'it\' at the beginning"
  fi
done
read wait
