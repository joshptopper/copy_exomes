Author: Joshua Topper

The goal of these scripts are to determine suitable candidates for gene knockout given clinical data
and a list of motifs of interest. 

NOTE: The following scripts must be in the copy_exomes directory. They must be executed in this order.
copyExomes.sh
createCrisprReady.sh
identifyCrisprSite.sh
editGenome.sh
exomeReport.py

NOTE: The following files must be in the copy_exomes directory. These will be the input files.
clinical_data.txt
motif_list.txt

NOTE: The following directories must be in the copy_exomes directory.
exomes (contains different animal exomes as fasta files)
exomesCohort (this will contain all output fasta files)
        *If there is no exomesCohort directory, copyExomes.sh will make one. You can also manually make
        the directory by typing "mkdir exomesCohort" on the command line in the copy_exomes folder.

## copyExomes.sh ##
Execute the ./copyExomes.sh script inside of the copy_exomes folder.
This will:
Read in the information from clinical_data.txt and seperate out animals
that are between 20 and 30 mm in length. The animals that meet that criteria will have their exomes copied 
into the exomesCohort directory. 
If there is no exomesCohort directory, one will be made.

## createCrisprReady.sh ##
Execute the ./createCrisprReady.sh script inside of the copy_exomes folder.
This will: 
Identify the 3 highest occuring motifs in each exome in the exomesCohort directory.
The genes that have at least one of these motifs will be outputed in {exomename}_topmotifs.fasta,
corresponding to the name of each animal. 
For example: The genes in the chicken.fasta that meet the 
requirements will be outputed into a file called chicken_topmotifs.fasta in the exomesCohort folder.

## identifyCrisprSite.sh ##
Execute the ./identifyCrisprSite.sh script inside of the copy_exomes folder.
This will:
Identify suitable CRISPR sites inside each {exomename}_topmotifs.fasta file. This is done by 
finding 20bp long sequences preceeding "NGG" sequences (N is any base). The genes that meet the requirements
will be outputed to a new file called {exomename}_precrispr.fasta.
For example: The genes in chicken_topmotifs.fasta that meet the requirements will be 
outputed into a new file called chicken_precrispr.fasta in the exomesCohort folder.

## editGenome.sh ##
Execute the ./editGenome.sh script inside of the copy_exomes folder.
This will:
Edit the precrispr fasta files by adding an Adenine (A) into the sequence preceeding the "NGG" site.
The new sequences will be outputed into a new file called {exomename}_postcrispr.fasta. 
For example: The genes in the chicken_precrispr.fasta will be edited and then outputed to 
a new file called chicken_postcrispr.fasta in the exomesCohort folder.

## exomeReport.py ##
Execute this script by typing 'python3 editGenome.py' and executing it inside the copy_exomes folder.
This will:
Generate a complete report of all edited sequences, the name of who discovered the organism, 
the diameter, the code name (organism name), and the environment where it was found. It will also, 
provide the location of the file and print the first edited gene sequence from that file. 
The complete report will be outputed to a file called summary_report.txt in the copy_exomes folder. 


