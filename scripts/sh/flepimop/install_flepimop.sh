#!/bin/bash

export FLEPI_PATH=$(pwd)/flepiMoP
export PROJECT_PATH=$(pwd)
export DATA_PATH=$(pwd)

cd $FLEPI_PATH
pip install -e flepimop/gempyor_pkg/ # Install Python package gempyor (and dependencies)

# while in R
Rscript -e 'install.packages(c("tidyverse","curl"))'
Rscript -e 'install.packages(c("readr","sf","lubridate","gridExtra","reticulate","truncnorm","xts","ggfortify","flextable","doParallel","foreach","optparse"))'
Rscript -e 'install.packages("arrow", repos = c("https://apache.r-universe.dev", "https://cran.r-project.org"))'
Rscript -e 'install.packages(c("devtools","cowplot","ggraph"))'


Rscript build/local_install.R  # Install R packages

cd $PROJECT_PATH       # goes to your project repository
#rm -r model_output/ # delete the outputs of past run if there are

if [[ -d /midas/model_input ]]; 
then
	mkdir model_input/
	cp /midas/model_input/*.* model_input/
else
	echo "  Error: Couldn't find model_input folder.  Please create the folder and place your input file in the folder."
	exit 1
fi

if [[ -d /midas/data ]]; 
then
	mkdir data/
	cp /midas/data/*.* data/
fi

