#!/bin/bash

# arg 1 is counts in clock.sh
# arg 2 is what pi this is
# arg 3 is currentHour in clock.sh
# arg 4 is interval in clock.sh
# arg 5 is boot in clock.sh

cd data${1}
f=${3}currentHour.csv
nf=pi${2}-${f}

#remove EST
sed -i 's/EST //' $f

#remove .[randomnumbers]-05:00 from readrtc entry
sed -i 's/.[0-9]*-05:00//' $f

#remove three letter day
sed -i 's/^[A-Z][a-z][a-z] //' $f

#replace spaces with commas
sed -i 's/ /,/g' $f

#add a column with line numbers and save to new file
awk '{printf "%s,%s\n", NR,$0}' $f > $nf

rm $f

#email new file
b="current hour: "${3}" -- interval period:"${4}" -- boot time:"${5}
echo $b | mutt -s "PI$(2): $(date)" raspberrysatellites@gmail.com -y -a $nf
cd ..
