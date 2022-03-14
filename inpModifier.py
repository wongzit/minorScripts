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

for k in fileNameList:
	with open(k, 'r') as inPutFile:
		inputLine = inPutFile.readlines()
	for l in range(len(fileNameList)):
		newInput = open(f"{fileName}/new/{newName}_{str(l+1)}.gjf", "w")
		for m in range(len(inputLine)):
			if m != 2 and m != 3 and m != 5:
				newInput.write(inputLine[m])
			elif m == 2:
				newInput.write(f"%chk={newName}_{str(l+1)}.chk\n")
			elif m == 3:
				newInput.write("Routine line\n")
			elif m == 5:
				newInput.write("Title Section")

		newInput.close()

