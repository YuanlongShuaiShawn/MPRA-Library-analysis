#!/bin/bash
#match the barcode and assign the sequence file to 24 separate files
for file in $(ls output*.txt);
	do
	echo "Processing $file:";
	echo "Total: $(cat $file | wc -l)";
	i=1;
	for barcode in $(cat Barcode.txt); 
		do
		grep "${barcode}CCTTGCTCACCATGGTGGCACCGGT" $file > ${i}_$file;
		echo "Fraction ${i}: $(cat ${i}_$file | wc -l)";
		let i++;
		done
	done