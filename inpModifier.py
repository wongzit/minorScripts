#! /Library/Frameworks/Python.framework/Versions/3.9/bin/python3

import platform

osVer = platform.system()

print("Input folder path:")
if osVer == 'Windows':
	fileName = input("(e.g.: C:\\examples)\n")
	if fileName.strip()[0] == '\'' and fileName.strip()[-1] == '\'':
		fileName = fileName.strip()[1:-1]
	elif fileName.strip()[0] == '\"' and fileName.strip()[-1] == '\"':
		fileName = fileName.strip()[1:-1]
	else:
		fileName = fileName.strip()
else:
	fileName = input("(e.g.: /examples)\n")
	if fileName.strip()[0] == '\"' and fileName.strip()[-1] == '\"':
		fileName = fileName.strip()[1:-1]
	elif fileName.strip()[0] == '\'' and fileName.strip()[-1] == '\'':
		fileName = fileName.strip()[1:-1]
	else:
		fileName = fileName.strip()

slashNo = 0
for i in range(len(fileName)):
	if fileName[i] == '/':
		slashNo = i

shortName = fileName[slashNo+1:]

newName = input("Input new file name:\n")

maxFileNo = 100
#print(newName)
fileNameList = []
for j in range(1, maxFileNo):
	currentFileTest = f"{fileName}/{shortName}_{str(j)}.gjf"
	try:
		with open(currentFileTest, 'r') as inPutF:
			fileNameList.append(currentFileTest)
	except FileNotFoundError:
		break

for k in range(len(fileNameList)):
	with open(fileNameList[k], 'r') as inPutFile:
		inputLine = inPutFile.readlines()

	newInput = open(f"{fileName}/new/{newName}_{str(k+1)}.gjf", "w")
	for m in range(len(inputLine)):
		if m != 2 and m != 3 and m != 5:
			newInput.write(inputLine[m])
		elif m == 2:
			newInput.write(f"%chk={newName}_{str(k+1)}.chk\n")
		elif m == 3:
			newInput.write("#p rcam-b3lyp/6-31g(d) conterpoise=2\n")
		elif m == 5:
			newInput.write("Title Section\n")
	newInput.close()
	inputLine = []

