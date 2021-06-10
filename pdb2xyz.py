# pdb2xyz v1.0
# Convert .xyz to .cml, powered by Python 3.9
# Last Update: 2021-05-24
# Author: Zhe Wang
# Homepage: https://www.wangzhe95.net/program
# xyz2cml reads mol.xyz file at current dictionary and convert it to mol-bohr.cml

print("*******************************************************************************")
print("*                                                                             *")
print("*                                p d b 2 x y z                                *")
print("*                                                                             *")
print("*     ======================= Convert .pdb to .xyz ======================     *")
print("*                           Last update: 2021-06-10                           *")
print("*                                                                             *")
print("*                             -- Catch me with --                             *")
print("*                         E-mail  wongzit@yahoo.co.jp                         *")
print("*                       Homepage  https://www.wangzhe95.net                   *")
print("*                         GitHub  https://github.com/wongzit                  *")
print("*                                                                             *")
print("*******************************************************************************")
print("\nPRESS Ctrl+c to exit the program.\n")

# ========================== Read original input file ==========================
print("Please specify the .pdb file path:")

# For Unix/Linux OS
fileName = input("(e.g.: ./Desktop/molecule.pdb)\n")
if fileName.strip()[0] == '\'' and fileName.strip()[-1] == '\'':
    fileName = fileName.strip()[1:-1]

# For Microsift Windows
#fileName = input("(e.g.: C:\\Desktop\\molecule.pdb)\n")
#if fileName.strip()[0] == '\"' and fileName.strip()[-1] == '\"':
#    fileName = fileName.strip()[1:-1]

with open(fileName.strip(), 'r') as pdbFile:
	pdbFileLines = pdbFile.readlines()
pdbCoors = []

for pdbFileLine in pdbFileLines:
	if "HETATM" in pdbFileLine:
		pdbCoors.append(pdbFileLine.strip())

totalAtom = int(pdbCoors[-1].split()[1])

allAtomList = []
for i in range(totalAtom):
	atomList = []
	atomList.append(pdbCoors[i].split()[2])
	for j in range(len(pdbCoors[i].split())):
		if "." in pdbCoors[i].split()[j]:
			atomList.append(pdbCoors[i].split()[j])
	allAtomList.append(atomList)

xyzFile = open(f"{fileName.strip()[:-3]}xyz", 'w')

xyzFile.write(f"{totalAtom}\n")
xyzFile.write("Generate by pdb2xyz, Zhe Wang\n")
for j in range(totalAtom):
	xyzFile.write(f" {allAtomList[j][0]}       {format(float(allAtomList[j][1]), '.6f')}     \
{format(float(allAtomList[j][2]), '.6f')}       {format(float(allAtomList[j][3]), '.6f')}\n")
xyzFile.close()

print("\n*******************************************************************************")
print("")
print("     The .xyz file has been saved at the same dictionary with .pdb file.")
print("                       Normal termination of xyz2cml.")
print("")
print("*******************************************************************************\n")