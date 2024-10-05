#!/bin/bash
#Author: Joshua Topper


#make variables for input files and directories
motif_list_file="motif_list.txt"
exomes_cohort_directory="exomesCohort"
output_directory="exomesCohort"

#loop through each exome file in exomesCohort
for exome_file in "$exomes_cohort_directory"/*.fasta; do
    #extract the code name from the exome filename
    code_name=$(basename "$exome_file" .fasta)

    #create temporary file to store sequences
    temp_seq_file=$(mktemp)

    #use awk to count motif occurrences and print the top 3 motifs
    top_motifs=$(awk -v RS='[ \n]+' '{count[$1]++} END {for (motif in count) print count[motif], motif}' "$motif_list_file" | sort -nr | awk 'NR<=3 {print $2}')
    
    #loop through each motif in the top 3 motifs
    for motif in $top_motifs; do
        # Use awk to extract corresponding sequences
        awk -v motif="$motif" '/^>/{header=$0; sub(/^>/, "", header); next} $0~motif{print ">" header; print $0}' "$exome_file" >> "$temp_seq_file"
    done

    #combine headers and sequences into the final output file
    cat "$temp_seq_file" > "$output_directory/${code_name}_topmotifs.fasta"

    #remove temporary file
    rm "$temp_seq_file"
done



