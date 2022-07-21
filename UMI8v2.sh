#!/bin/bash
mkdir output
#Determine how many sequence per UMI(whose length is 8)
for file in $(ls *_output*.txt);
do
#echo "Processing ${file}:";
#echo "Total:$(cat $file | wc -l)";
cat $file | cut -b 1-8 | sort | uniq > UMI.txt;
#echo "Unique UMI: $(cat UMI.txt | wc -l)";
for UMI in $(cat UMI.txt);
do
number=$(grep "^$UMI" $file | wc -l);
echo "$UMI,$number" >> UMI$file;
done
done
#Generate the list of "different UMI numbers, count"
for file in $(ls UMI*_output*.txt)
do
for((i=1;i<=200;i++));
do
number=$(grep ",$i$" $file | wc -l)
echo "$i,$number">> ls$file
done
done
mv lsUMI*_output*.txt output