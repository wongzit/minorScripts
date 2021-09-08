#! /bin/bash

echo =================================================
echo "+                                               +"
echo "+            R u n G J F ( I C S S )            +"
echo "+ ---------------- Version 2.0 ---------------- +"
echo "+                                               +"
echo "+    Bash shell script for automatic runing     +"
echo "+   Gaussian and ORCA jobs, by Zhe Wang.        +"
echo "+                                               +"
echo "+           https://wongzit.github.io           +"
echo "+                                               +"
echo =================================================

gjfs=$(ls ./*.gjf 2>/dev/null | wc -l)
while [ $gjfs -gt 0 ]
do
	nFiles=$(ls ./*.gjf | wc -l)
	echo
	echo Found $nFiles Gaussian inputs.
	echo

	fileCount=0
	for inputFile in *.gjf
	do
		((fileCount++))
		echo Running $inputFile ... \($fileCount of $nFiles\)
		g16 < ${inputFile} > ${inputFile//gjf/log}
		echo $inputFile has finished!
	echo
	done
	gjfs=$(ls ./*.gjf 2>/dev/null | wc -l)
done

echo All jobs have finished, termination of RunGJF.
echo

# https://github.com/wongzit/minorScripts
# by Zhe Wang at Hiroshima University
