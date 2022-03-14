# About minorScripts

This repo includes some small/minor scripts written by Zhe Wang.

**E-mail** wongzit@yahoo.co.jp

**Homepage** https://wongzit.github.io

## TASvis3D v0.1 (2019-05-16)
*TASvis3D* is my personal Mathematica .nb for visualize transient absorption spectra in 3D view. Origin can do the same thing.
A .csv file which containing TAS data points is necessary for using this .nb file.

## xyz2cml v1.0 (2021-05-24)
*xyz2cml* is a Python script for converting .xyz file to .cml file.
I wrote this script for my [GIMIC](https://github.com/qmcurrents/gimic) calculation.
It reads *mol.xyz* file at current dictionary and convert it to *mol-bohr.cml* file.
The unit would be changed to Bohr rather than Angstrom.

## RunGJF v0.6 (2021-06-05)
*RunGJF* is a Bash Shell script for running Gaussian jobs automatically.
*RunGJF* reads all .gjf files in current dictionary, and submit the to Gaussian 16 calculation one by one.
If you want to convert the .chk to .fchk files and move each job to a single folder after finishing one calculation,
please un-comment the line 29-31 in the source code.

**v2.0 update at 2021-09-07**: Add support for ORCA. Improved code quailty.

**v1.1 Update at 2021-07-01**: a script for running RunGJF for LSF job system is uploaded.

## RunICSS v2.0 (2021-09-08)
A ICSS version of *RunGJF*. *RunICSS* will not convert .chk file to .fchk and make folder for each job.

## gimicInp v0.2 for Python (2021-06-07)
*gimicInp* is a Python script for generating GIMIC input file.
User can specify the parameters and the input file **gimic.inp** will be saved at current dictionary.

## gimicInp v0.3 for Bash Shell (2021-06-08)
I provided a Bash shell version of *gimicInp*.
The functions are same in both Python and Bash shell scripts.

## pdb2xyz v1.0 (2021-06-10)
*pdb2xyz* is a Python script for converting .pdb file to .xyz file.

## pdb2gjf v1.0 (2021-10-25)
*pdb2gjf* is a Python script for creating Gaussian input file (*.gjf*) from protein data bank file (*.pdb*).

## Planirty_checker (2021-11-15)
Check the planirty of a molecule. Visualizing with VMD.

## inpModifier (2022-03-14)
Modify several Gaussian input files at once.
