#! /bin/bash

echo =================================================
echo "+                                               +"
echo "+                  R u n G J F                  +"
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
		if [ -e ${inputFile//gjf/chk} ];then
			formchk ${inputFile//gjf/chk}
		fi
		mkdir ${inputFile//.gjf}
		mv ${inputFile//gjf/*} ./${inputFile//.gjf}
		echo $inputFile has finished!
	echo
	done
	gjfs=$(ls ./*.gjf 2>/dev/null | wc -l)
done

inps=$(ls ./*.inp 2>/dev/null | wc -l)
while [ $inps -gt 0 ]
do
	nFiles=$(ls ./*.inp | wc -l)
	echo
	echo Found $nFiles ORCA inputs.
	echo

	fileCount=0
	for inputFile in *.inp
	do
		((fileCount++))
		echo Running $inputFile ... \($fileCount of $nFiles\)
		orca ${inputFile} > ${inputFile//inp/out}
		mkdir ${inputFile//.inp}
		mv ${inputFile//inp/*} ./${inputFile//.inp}
		echo $inputFile has finished!
	echo
	done
	inps=$(ls ./*.inp 2>/dev/null | wc -l)
done

echo All jobs have finished, termination of RunGJF.
echo

# https://github.com/wongzit/minorScripts
# by Zhe Wang at Hiroshima University
