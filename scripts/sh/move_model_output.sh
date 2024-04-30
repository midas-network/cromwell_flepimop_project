#!/bin/bash

if [[ ! -d /midas/model_output ]]; 
then
  mkdir /midas/model_output
fi

echo "Providing easy access to stderr and stdout..."
cp -f stderr /midas/model_output/
cp -f stdout /midas/model_output/

echo "Verifying model output folder exists from sucessful run..."
if [[ -d model_output ]]; 
then
  echo "  model_output folder found!";
  cp -r model_output /midas/
else
  echo "  Error: Couldn't find model_output folder.  The run was not successful."
  exit 1
fi
