#! /bin/bash

# https://github.com/wongzit/minorScripts
echo =================================================
echo "+                                               +"
echo "+                  R u n G J F                  +"
echo "+ ---------------- Version 1.1 ---------------- +"
echo "+                                               +"
echo "+     Bash Shell script for runing Gaussian     +"
echo "+   jobs aotumatically, Written by Zhe Wang.    +"
echo "+                                               +"
echo "+           https://www.wangzhe95.net           +"
echo =================================================

nFilescur=$(ls ./*.gjf | wc -l)
while [ $nFilescur -gt 0 ]
do
	nFiles=$(ls ./*.gjf | wc -l)
	echo
	echo Found $nFiles input files.
	echo

	fileCount=0
	for inputFile in *.gjf
	do
		((fileCount++))
		echo Running $inputFile ... \($fileCount of $nFiles\)
		g16 < ${inputFile} > ${inputFile//gjf/log}
		formchk ${inputFile//gjf/chk}
		mkdir ${inputFile//.gjf}
		mv ${inputFile//gjf/*} ./${inputFile//.gjf}
		echo $inputFile has finished!
	echo
	done
	nFilescur=$(ls ./*.gjf | wc -l)
done

echo All jobs have finished, termination of RunGJF.
echo
