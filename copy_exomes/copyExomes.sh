#!/bin/bash
#Author: Joshua Topper

#make variables for input files
clinical_data_file="clinical_data.txt"
exomes_directory="exomes"
output_directory="exomesCohort"

#create exomesCohort if it doesn't exist
mkdir -p "$output_directory"

#read the clinical data and copy relevant exomes
while IFS=$'\t' read -r Discoverer Location Diameter Environment Status Code_name
do 
    #convert "Sequenced" and "Not sequenced" to lowercase to make it easier to compare
    Status=$(echo "$Status" | tr '[:upper:]' '[:lower:]')
    #compare clinical data so it meets the requirements
    if [ "$Status" == "sequenced" ] && [ "$((Diameter))" -ge 20 ] && [ "$((Diameter))" -le 30 ]; then
        echo "Copying: $exomes_directory/$Code_name.fasta to $output_directory/"
        cp "$exomes_directory/$Code_name.fasta" "$output_directory/"
    fi
done < "$clinical_data_file"
