#! /bin/bash

# https://github.com/wongzit/minorScripts
echo =================================================
echo "+                                               +"
echo "+                  R u n G J F                  +"
echo "+ ---------------- Version 0.6 ---------------- +"
echo "+                                               +"
echo "+     Bash Shell script for runing Gaussian     +"
echo "+   jobs aotumatically, Written by Zhe Wang.    +"
echo "+                                               +"
echo "+           https://www.wangzhe95.net           +"
echo =================================================

nFiles=$(ls ./*.gjf | wc -l)
echo
echo Found $nFiles input files.
echo

# For running formchk and creating folder for each
# job, please un-comment the ling 29-31

fileCount=0
for inputFile in *.gjf
do
	((fileCount++))
	echo Running $inputFile ... \($fileCount of $nFiles\)
	g16 < ${inputFile} > ${inputFile//gjf/log}
#	formchk ${inputFile//gjf/chk}
#	mkdir ${inputFile//.gjf}
#	mv ${inputFile//gjf/*} ./${inputFile//.gjf}
	echo $inputFile has finished!
echo
done

echo All jobs have finished, termination of RunGJF.
echo