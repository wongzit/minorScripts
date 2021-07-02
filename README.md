# About minorScripts

This repo includes some small/minor scripts written by Zhe Wang.

**E-mail** wongzit@yahoo.co.jp

**Homepage** https://www.wangzhe95.net

## TASvis3D v0.1 (2019-05-16)
*TASvis3D* is my personal Mathematica .nb for visualize transient absorption spectra in 3D view. Origin can do the same thing.
A .csv file is necessary for using this .nb file.

## xyz2cml v1.0 (2021-05-24)
*xyz2cml* is a Python script for converting .xyz file to .cml file.
I wrote this script for my [GIMIC](https://github.com/qmcurrents/gimic) calculation.
It reads *mol.xyz* file at current dictionary and convert it to *mol-bohr.cml* file.
The unit would be changed to Bohr rather than Angstrom.

## RunGJF v1.1 (2021-06-05)
*RunGJF* is a Bash Shell script for running Gaussian jobs automatically.
*RunGJF* reads all .gjf files in current dictionary, and submit the to Gaussian 16 calculation one by one.
If you want to convert the .chk to .fchk files and move each job to a single folder after finishing one calculation,
please un-comment the line 29-31 in the source code.


**Update at 2021-07-01**: a script for running RunGJF for LSF job system is uploaded.

## gimicInp v0.2 for Python (2021-06-07)
*gimicInp* is a Python script for generating GIMIC input file.
User can specify the parameters and the input file **gimic.inp** will be saved at current dictionary.

## gimicInp v0.3 for Bash Shell (2021-06-08)
I provided a Bash shell version of *gimicInp*.
The functions are same in both Python and Bash shell scripts.

## pdb2xyz v1.0 (2021-06-10)
*pdb2xyz* is a Python script for converting .pdb file to .xyz file.
