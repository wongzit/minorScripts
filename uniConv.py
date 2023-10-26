#! /Library/Frameworks/Python.framework/Versions/3.11/bin/python3

# Energy Converter v0.2 by Zhe Wang

import sys

if len(sys.argv) == 3:
	inpVal_1 = float(sys.argv[1])
	inpVal_2 = 0.0
	inpUnit = sys.argv[2]

elif len(sys.argv) == 4:
	inpVal_1 = float(sys.argv[1])
	inpVal_2 = float(sys.argv[2])
	inpUnit = sys.argv[3]

else:
	print("Input Error, program exit.")
	exit()

#inpVal_2 = 0
#inpUnit = 'kcal/mol'

if inpUnit.lower() == 'hartree' or inpUnit.lower() == 'har' or inpUnit.lower() == 'h':
	print(f"Convert {round((inpVal_1 - inpVal_2), 6)} Hartree to:")
	print(f"{round((inpVal_1 - inpVal_2)*627.5095, 3)} kcal/mol")
	print(f"{round((inpVal_1 - inpVal_2)*2625.4999620953677, 3)} kJ/mol")
	print(f"{round((inpVal_1 - inpVal_2)*27.2113838668, 3)} eV")
	print(f"{round((inpVal_1 - inpVal_2)*219474.63, 3)} cm**-1")
	print(f"{round(10000000/(inpVal_1 - inpVal_2)/219474.63, 3)} nm")

elif inpUnit.lower() == 'ev':
	print(f"Convert {round((inpVal_1 - inpVal_2), 6)} eV to:")
	print(f"{round((inpVal_1 - inpVal_2)*23.0609, 3)} kcal/mol")
	print(f"{round((inpVal_1 - inpVal_2)*96.4869, 3)} kJ/mol")
	print(f"{round((inpVal_1 - inpVal_2)*0.0367502, 3)} Hartree")
	print(f"{round((inpVal_1 - inpVal_2)*8065.73, 3)} cm**-1")
	print(f"{round(10000000/(inpVal_1 - inpVal_2)/8065.73, 3)} nm")

elif inpUnit.lower() == 'kj/mol' or inpUnit.lower() == 'kj':
	print(f"Convert {round((inpVal_1 - inpVal_2), 6)} kJ/mol to:")
	print(f"{round((inpVal_1 - inpVal_2)*0.239001, 3)} kcal/mol")
	print(f"{round((inpVal_1 - inpVal_2)*0.00038088, 3)} Hartree")
	print(f"{round((inpVal_1 - inpVal_2)*0.01036410, 3)} eV")
	print(f"{round((inpVal_1 - inpVal_2)*83.593, 3)} cm**-1")
	print(f"{round(10000000/(inpVal_1 - inpVal_2)/83.593, 3)} nm")

elif inpUnit.lower() == 'kcal/mol' or inpUnit.lower() == 'kcal':
	print(f"Convert {round((inpVal_1 - inpVal_2), 6)} kcal/mol to:")
	print(f"{round((inpVal_1 - inpVal_2)*0.00159362, 3)} Hartree")
	print(f"{round((inpVal_1 - inpVal_2)*4.184, 3)} kJ/mol")
	print(f"{round((inpVal_1 - inpVal_2)*0.0433634, 3)} eV")
	print(f"{round((inpVal_1 - inpVal_2)*349.757, 3)} cm**-1")
	print(f"{round(10000000/(inpVal_1 - inpVal_2)/349.757, 3)} nm")

else:
	print("Input Error, program exit.")