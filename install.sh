#!/bin/bash

#echo "export PYTHON=~/jupyter" > ~/.bashrc
#echo "export PASSWORD=`$1`" > ~/.bashrc
mkdir jupyter
virtualenv -p python3 ~/.env
. ~/.env/bin/activate 
pip3 install -r requiriments.txt
ln -s /var/jupyter/shared ~/jupyter/shared
ln -s /var/jupyter/libs  ~/jupyter/libs 
mkdir ~/.jupyter
cp src/jupyter_notebook_config.py ~/.jupyter/
cp -R src/examples ~/jupyter/
cp -R src/libs/* /var/jupyter/libs
cp -R src/start.sh ~/jupyter/

