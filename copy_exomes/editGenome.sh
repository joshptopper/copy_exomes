#!/bin/bash
#Author: Joshua Topper

#make variables for input files and directories
input_directory="exomesCohort"
output_directory="exomesCohort"

#loop through each precrispr file in exomesCohort
for precrispr_file in "$input_directory"/*_precrispr.fasta; do
    #extract the code name from the precrispr filename
    code_name=$(basename "$precrispr_file" _precrispr.fasta)

    #use awk to insert the letter A before each "NGG" site (N being any nucleotide)
    awk '
        /^>/{print; next}
        {gsub(/[ACGT]GG/, "A&"); print}
    ' "$precrispr_file" > "$output_directory/${code_name}_postcrispr.fasta"
done
