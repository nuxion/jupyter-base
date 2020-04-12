#!/bin/bash
export PYTHONPATH=~/jupyter
export PASSWORD=$1
. ~/.env/bin/activate
jupyter-lab 
