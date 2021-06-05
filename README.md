# About minorScripts

This repo includes some small/minor scripts written by Zhe Wang.

**E-mail** wongzit@yahoo.co.jp

**Homepage** https://www.wangzhe95.net

## xyz2cml (2021-05-24)
*xyz2cml* is a Python script for converting .xyz file to .cml file.
I wrote this script for my [GIMIC](https://github.com/qmcurrents/gimic) calculation.
It reads *mol.xyz* file at current dictionary and convert it to *mol-bohr.cml* file.
The unit would be changed to Bohr rather than Angstrom.

## RunGJF (2021-06-05)
*RunGJF* is a Bash Shell script for running Gaussian jobs automatically.
*RunGJF* reads all .gjf files in current dictionary, and submit the to Gaussian 16 calculation one by one.
If you want to convert the .chk to .fchk files and move each job to a single folder after finishing one calculation,
please un-comment the line 29-31 in the source code.
