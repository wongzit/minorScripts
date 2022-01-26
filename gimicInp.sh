#！ /bin/bash

# Developed by Zhe Wang, Hiroshima University
# https://www.wangzhe95.net
# https://github.com/wongzit/minorScripts

echo "*******************************************************************************"
echo "*                                                                             *"
echo "*                               g i m i c I n p                               *"
echo "*                                                                             *"
echo "*     ===================== Bash Shell Version, v0.3 ====================     *"
echo "*                           Last update: 2021-06-09                           *"
echo "*                                                                             *"
echo "*                             -- Catch me with --                             *"
echo "*                         E-mail  wongzit@yahoo.co.jp                         *"
echo "*                       Homepage  https://www.wangzhe95.net                   *"
echo "*                         GitHub  https://github.com/wongzit                  *"
echo "*                                                                             *"
echo "*******************************************************************************"

echo

gimicInp="gimic.inp"

calc=cdens
basis=./MOL
xdens=./XDENS
openshell="false"
magnet="0,0,1"
gridType=even
gridOrigin="-8.0, -7.0, -6.0"
ivec="1.0, 0.0, 0.0"
jvec="0.0, 1.0, 0.0"
lengths="16.0, 14.0, 12.0"
gridPoint="50, 50, 50"
spherical=off
diamag=on
paramag=on
acid=on
jmod=on

userInput=abc

while [[ true ]]; do

	echo "======================== Current parameters ======================="
	echo "    1 - Calculation type: $calc"
	echo "    2 - MOL file path: $basis"
	echo "    3 - XDENS file path: $xdens"
	echo "    4 - Open-shell calculation: $openshell"
	echo "    5 - External magnet field: $magnet"
	echo "-------------------------- Grid Section --------------------------"
	echo "    6 - Grid types = $gridType"
	echo "    7 - Origin of grid (bottom left cornor): $gridOrigin"
	echo "    8 - Direction of vertical basis vector: $ivec"
	echo "    9 - Direction of the horizontal basis vector: $jvec"
	echo "   10 - Length of each side of the cube: $lengths"
	echo "   11 - Number of grid points in each direction: $gridPoint"
	echo "   12 - Use spherical Cartesian: $spherical"
	echo "   13 - Turn on/off diamagnetic contributions: $diamag"
	echo "   14 - Turn on/off paramagnetic contributions: $paramag"
	echo "   15 - Turn on/off ACID calculation: $acid"
	echo "   16 - Turn on/off the mod(J) integral calculation: $jmod"
	echo "=================================================================="
	echo ""
	echo "Press 0 to use current settings, input number to modify the parameters:"

	read userInput

	if [[ $userInput = 1 ]]; then
	echo "Calculation type (cdens/integral):"
	read calc
	elif [[ $userInput = 2 ]]; then
	echo "MOL file path:"
	read basis
	elif [[ $userInput = 3 ]]; then
	echo "XDENS file path:"
	read xdens
	elif [[ $userInput = 4 ]]; then
	echo "Open-shell calculation? Input true or false:"
	read openshell
	elif [[ $userInput = 5 ]]; then
	echo "External magnetic field:"
	read magnet
	elif [[ $userInput = 6 ]]; then
	echo "Grid type (even/base/bond):"
	read gridType
	elif [[ $userInput = 7 ]]; then
	echo "Origin of grid (bottom left cornor):"
	read gridOrigin
	elif [[ $userInput = 8 ]]; then
	echo "Direction of vertical basis vector:"
	read ivec
	elif [[ $userInput = 9 ]]; then
	echo "Direction of the horizontal basis vector:"
	read jvec
	elif [[ $userInput = 10 ]]; then
	echo "Length of each side of the cube:"
	read lengths
	elif [[ $userInput = 11 ]]; then
	echo "Number of grid points in each direction:"
	read gridPoint
	elif [[ $userInput = 12 ]]; then
	echo "Use spherical Cartesian (on/off):"
	read spherical
	elif [[ $userInput = 13 ]]; then
	echo "Turn on/off diamagnetic contributions (on/off):"
	read diamag
	elif [[ $userInput = 14 ]]; then
	echo "Turn on/off paramagnetic contributions (on/off):"
	read paramag
	elif [[ $userInput = 15 ]]; then
	echo "Turn on/off ACID calculation (on/off):"
	read acid
	elif [[ $userInput = 16 ]]; then
	echo "Turn on/off the mod(J) integral calculation (on/off):"
	read jmod
	elif [[ $userInput = 0 ]]; then
	break
	else
	echo "Input error, use current settings."
	fi
done

echo calc=$calc > $gimicInp
echo basis=\"$basis\" >> $gimicInp
echo xdens=\"$xdens\" >> $gimicInp
echo openshell=$openshell >> $gimicInp
echo magnet=[$magnet] >> $gimicInp
echo >> $gimicInp

echo "Grid(base) {" >> $gimicInp
echo "    type=$gridType" >> $gimicInp
echo "    origin=[$gridOrigin]" >> $gimicInp
echo "    ivec=[$ivec]" >> $gimicInp
echo "    jvec=[$jvec]" >> $gimicInp
echo "    lengths=[$lengths]" >> $gimicInp
echo "    grid_points=[$gridPoint]" >> $gimicInp
echo "}" >> $gimicInp
echo >> $gimicInp

echo "Advanced {" >> $gimicInp
echo "    spherical=$spherical" >> $gimicInp
echo "    diamag=$diamag" >> $gimicInp
echo "    paramag=$paramag" >> $gimicInp
echo "}" >> $gimicInp
echo >> $gimicInp

echo "Essential {" >> $gimicInp
echo "    acid=$acid" >> $gimicInp
echo "    jmod=$jmod" >> $gimicInp
echo "}" >> $gimicInp
echo >> $gimicInp

echo
echo "*******************************************************************************"
echo
echo "                 gimic.inp has been created in current folder.                 "
echo
echo "*******************************************************************************"
