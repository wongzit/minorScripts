import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import platform
import math

def elementNo (element):
    eleNumber = 6.000000
    periodTable = ['Bq', 'H', 'He', 'Li', 'Be', 'B', 'C', 'N', 'O', 'F', 'Ne', 'Na', 'Mg', 'Al', 'Si', 'P', 'S', 'Cl', 'Ar', \
                    'K', 'Ca', 'Sc', 'Ti', 'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr', \
                    'Rb', 'Sr', 'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te', 'I', 'Xe', \
                    'Cs', 'Ba', 'La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Ym', 'Yb', 'Lu', 'Ha', 'Ta', \
                    'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Rn', 'Fr', 'Ra', 'Ac', 'Th', 'Pa', 'U', \
                    'Np', 'Pu', 'Am', 'Cm', 'Bk', 'Cf', 'Es', 'Fm', 'Md', 'No', 'Lr', 'Rf', 'Db', 'Sg', 'Bh', 'Hs', 'Mt', 'Ds', 'Rg', \
                    'Cn', 'Nh', 'Fl', 'Mc', 'Lv', 'Ts', 'Og']
    eleNumber = periodTable.index(element)
    return eleNumber

periodTable = ['Bq', 'H', 'He', 'Li', 'Be', 'B', 'C', 'N', 'O', 'F', 'Ne', 'Na', 'Mg', 'Al', 'Si', 'P', 'S', 'Cl', 'Ar', \
                'K', 'Ca', 'Sc', 'Ti', 'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr', \
                'Rb', 'Sr', 'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te', 'I', 'Xe', \
                'Cs', 'Ba', 'La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Ym', 'Yb', 'Lu', 'Ha', 'Ta', \
                'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Rn', 'Fr', 'Ra', 'Ac', 'Th', 'Pa', 'U', \
                'Np', 'Pu', 'Am', 'Cm', 'Bk', 'Cf', 'Es', 'Fm', 'Md', 'No', 'Lr', 'Rf', 'Db', 'Sg', 'Bh', 'Hs', 'Mt', 'Ds', 'Rg', \
                'Cn', 'Nh', 'Fl', 'Mc', 'Lv', 'Ts', 'Og']
atomRadius = ['0.0000', '1.2000', '1.4000', '2.2400', '1.8600', '1.9200', '1.7000', '1.5500', '1.4000', '1.3500', '1.5400', '2.5700', '2.2700', '1.8400', '2.1000', '1.8000', '1.8500', '1.8000', 'Ar', \
                '3.0000', '2.6100', '2.2800', '2.1400', '2.0300', '1.9700', '1.9600', '1.9600', '1.9500', '1.9400', '2.00000', '2.0200', '2.0800', '2.1300', '2.1600', 'Se', '1.9500', 'Kr', \
                '3.1200', '2.7800', 'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te', '2.1500', 'Xe', \
                '3.3100', '2.8500', 'La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Ym', 'Yb', 'Lu', 'Ha', 'Ta', \
                '2.0700', '2.0500', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Rn', 'Fr', 'Ra', 'Ac', 'Th', 'Pa', 'U', \
                'Np', 'Pu', 'Am', 'Cm', 'Bk', 'Cf', 'Es', 'Fm', 'Md', 'No', 'Lr', 'Rf', 'Db', 'Sg', 'Bh', 'Hs', 'Mt', 'Ds', 'Rg', \
                'Cn', 'Nh', 'Fl', 'Mc', 'Lv', 'Ts', 'Og']

osVer = 'Darwin'
proVer = '1.0'
rlsDate = '2021-10-13'

#fileName = "/Users/wangzhe/Desktop/tempo_ct_ts_opt.log"


print("Gaussian input/output file: support .gjf/.com/.log/.out")
if osVer == 'Windows':
    fileName = input("(e.g.: C:\\pyAroma\\examples\\benzene.gjf)\n")
    if fileName.strip()[0] == '\'' and fileName.strip()[-1] == '\'':
        fileName = fileName.strip()[1:-1]
    elif fileName.strip()[0] == '\"' and fileName.strip()[-1] == '\"':
        fileName = fileName.strip()[1:-1]
    else:
        fileName = fileName.strip()
else:
    fileName = input("(e.g.: /pyAroma/examples/benzene.gjf)\n")
    if fileName.strip()[0] == '\"' and fileName.strip()[-1] == '\"':
        fileName = fileName.strip()[1:-1]
    elif fileName.strip()[0] == '\'' and fileName.strip()[-1] == '\'':
        fileName = fileName.strip()[1:-1]
    else:
        fileName = fileName.strip()


with open(fileName, 'r') as output:
    outputFile = output.readlines()

if fileName[-4:] == '.log' or fileName[-4:] == '.out':
    geoFlagStart = 0
    for j in range(len(outputFile)):
        if 'Standard orientation:' in outputFile[j]:
            geoFlagStart = j
    if geoFlagStart == 0:
        for k in range(len(outputFile)):
            if 'Input orientation:' in outputFile[k]:
                geoFlagStart = k
    for m in range(geoFlagStart + 5, len(outputFile)):
        if '------' in outputFile[m]:
            geoFlagEnd = m
            break
    coorLines = []
    for coorLine in outputFile[geoFlagStart + 5 : geoFlagEnd]:
        atomCoor = []
        atomCoor.append(int(coorLine.split()[1]))
        atomCoor.append(float(coorLine.split()[3]))
        atomCoor.append(float(coorLine.split()[4]))
        atomCoor.append(float(coorLine.split()[5]))
        coorLines.append(atomCoor)

elif fileName[-4:] == '.xyz':
    coorLines = []
    for a in range(2,len(outputFile)):
        atomCoor = []
        atomCoor.append(elementNo(outputFile[a].split()[0]))
        atomCoor.append(float(outputFile[a].split()[1]))
        atomCoor.append(float(outputFile[a].split()[2]))
        atomCoor.append(float(outputFile[a].split()[3]))
        coorLines.append(atomCoor)

mainFun = 1

if mainFun == 1:   # planarity analysis
    menu_1 = input("1-all, 2-heavy, 3-range, 4-specify\n")
    usrCoor = []

    if menu_1 == '1':
        usrCoor = coorLines
    elif menu_1 == '2':
        for l in range(len(coorLines)):
            if coorLines[l][0] != 1:
                usrCoor.append(coorLines[l])
    elif menu_1 == '3':
        startNo, endNo = input("2 numbers:\n").split()
        for k in range(int(startNo),int(endNo) + 1):
            usrCoor.append(coorLines[k - 1])
    elif menu_1 == '4':
        usrInpList = input("atom numbers\n")
        for n in usrInpList.split():
            usrCoor.append(coorLines[int(n) - 1])

    #print(usrCoor)
    xs = []
    ys = []
    zs = []
    x_tot = 0
    y_tot = 0
    z_tot = 0
    for i in range(len(usrCoor)):
        xs.append(usrCoor[i][1])
        ys.append(usrCoor[i][2])
        zs.append(usrCoor[i][3])
        x_tot += usrCoor[i][1]
        y_tot += usrCoor[i][2]
        z_tot += usrCoor[i][3]

    x_ave = x_tot / len(usrCoor)
    y_ave = y_tot / len(usrCoor)
    z_ave = z_tot / len(usrCoor)

    tmp_A = []
    tmp_b = []
    for i in range(len(xs)):
        tmp_A.append([xs[i], ys[i], 1])
        tmp_b.append(zs[i])
    b = np.matrix(tmp_b).T
    A = np.matrix(tmp_A)

    fit = (A.T * A).I * A.T * b
    d_value = fit[0] * x_ave + fit[1] * y_ave - z_ave
    for o in coorLines:
        #d_s = (fit[0]/fit[2] * o[1] + fit[1]/fit[2] * o[2] - 1/fit[2] * o[3] + 1) / math.sqrt(fit[0] * fit[0] / fit[2] / fit[2] + fit[1] * fit[1] / fit[2] / fit[2] + 1 / fit[2] / fit[2])
        #d_s = (fit[0] * o[1] + fit[1] * o[2] - o[3] + fit[2]) / math.sqrt(fit[0] * fit[0] + fit[1] * fit[1] + 1)
        d_s = (fit[0] * o[1] + fit[1] * o[2] - o[3] - d_value) / math.sqrt(fit[0] * fit[0] + fit[1] * fit[1] + 1)
        o.append(float(d_s))

    pqrFile = open(f"{fileName[:-4]}.pqr", 'w')
    for p in range(len(coorLines)):
        pqrFile.write("HETATM{:5d}".format(p+1))
        pqrFile.write(periodTable[coorLines[p][0]].rjust(3))
        pqrFile.write("   MOL A   1  ")
        pqrFile.write(f"  {format(coorLines[p][1], '8.3f')} {format(coorLines[p][2], '8.3f')} {format(coorLines[p][3], '8.3f')} {format(coorLines[p][4], '13.8f')}   ")
        pqrFile.write(atomRadius[coorLines[p][0]])
        pqrFile.write(periodTable[coorLines[p][0]].rjust(3))
        pqrFile.write("\n")
    pqrFile.close()



