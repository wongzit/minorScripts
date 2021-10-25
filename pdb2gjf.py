import platform

osVer = platform.system()

if osVer == 'Windows':
	fileName = input("PDB file path: (e.g.: C:\\wangzhe\\benzene.pdb)\n")
	if fileName.strip()[0] == '\'' and fileName.strip()[-1] == '\'':
		fileName = fileName.strip()[1:-1]
	elif fileName.strip()[0] == '\"' and fileName.strip()[-1] == '\"':
		fileName = fileName.strip()[1:-1]
	else:
		fileName = fileName.strip()
else:
	fileName = input("PDB file path: (e.g.: /wangzhe/benzene.pdb)\n")
	if fileName.strip()[0] == '\"' and fileName.strip()[-1] == '\"':
		fileName = fileName.strip()[1:-1]
	elif fileName.strip()[0] == '\'' and fileName.strip()[-1] == '\'':
		fileName = fileName.strip()[1:-1]
	else:
		fileName = fileName.strip()

with open(fileName, 'r') as pdbFile:
	pdbInfo = pdbFile.readlines()

gjfFile = open(f'{fileName[:-3]}gjf', 'w')

if osVer == 'Windows':
	pass
else:
	slaCount = 0
	for a in range(len(fileName)):
		if fileName[a] == '/':
			slaCount = a
	fileName2 = fileName[slaCount+1:-3]

print('Job type:')
print(' 1 - Closed-shell singlet')
print(' 2 - Open-shell singlet')
print(' 3 - Open-shell triplet')
print(' 4 - Open-shell doublet')
menu = input(' 5 - Leave routine line blank\n')

gjfFile.write('%nprocshared=8\n')
gjfFile.write('%mem=10GB\n')
gjfFile.write(f'%chk={fileName2}chk\n')
if menu == '1':
	gjfFile.write('#p opt freq rwb97xd/6-31g(d)\n\ntitle\n\n0 1\n')
elif menu == '2':
	gjfFile.write('#p opt freq uwb97xd/6-31g(d) guess=(mix,always)\n\ntitle\n\n0 1\n')
elif menu == '3':
	gjfFile.write('#p opt freq uwb97xd/6-31g(d)\n\ntitle\n\n0 3\n')
elif menu == '4':
	gjfFile.write('#p opt freq uwb97xd/6-31g(d)\n\ntitle\n\n0 2\n')
elif menu == '5':
	gjfFile.write('#\n\ntitle\n\n0 1\n')

for i in pdbInfo:
	if 'HETATM' in i:
		gjfFile.write(f'{i.split()[2]}      {i.split()[5]}      {i.split()[6]}      {i.split()[7]}\n')

gjfFile.write('\n')
gjfFile.close()