#!/bin/bash
#Author: Joshua Topper


#make variables for input files and directories
exomes_cohort_directory="exomesCohort"
output_directory="exomesCohort"

#loop through each topmotifs file in exomesCohort
for topmotifs_file in "$exomes_cohort_directory"/*_topmotifs.fasta; do
    #extract the code name from the topmotifs filename
    code_name=$(basename "$topmotifs_file" _topmotifs.fasta)

    #filter headers and sequences based on the "NGG" motif
    #can adjust upstream length value below if needed
    awk -v upstream_length=20 '
        /^>/{header=$0; seq_flag=0; next}
        $0~/[ATCG]GG/{seq_flag=1}
        seq_flag && length($0) > upstream_length {print header; print $0}
    ' "$topmotifs_file" > "$output_directory/${code_name}_precrispr.fasta"
done