#! /bin/bash

# Additional script for RunGJF
# Running this script with CPU core, e.g., ./run.sh 6
# Using 8 cores without specification
# Designed for BSUB job system
# Assuming that the RunGJF.sh file is locating at ~/wang/RunGJF.sh

if [ ! $1 ]
then
	bsub -n 8 "~/wang/RunGJF.sh"
else
	bsub -n $1 "~/wang/RunGJF.sh"
fi
