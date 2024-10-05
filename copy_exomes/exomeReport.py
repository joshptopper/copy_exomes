#Author: Joshua Topper

import os

def generate_report():
    input_directory = "exomesCohort"
    clinical_data_file = "clinical_data.txt"

    #make a text file for writing the report
    with open("summary_report.txt", "w") as report_file:

        #loop through each postcrispr file in exomesCohort
        for postcrispr_file in os.listdir(input_directory):
            if postcrispr_file.endswith("_postcrispr.fasta"):
                code_name = postcrispr_file.split("_")[0]

                #extract information from clinical data file
                discoverer, diameter, _, environment, *_ = get_clinical_data(clinical_data_file, code_name)

                #write organism information to the report
                report_file.write(
                    f"Organism {code_name}, discovered by {discoverer}, has a diameter of {diameter} mm, "
                    f"and is from the environment {environment}.\n"
                )

                #write the path to the postcrispr file in the report
                report_file.write(f"The list of genes can be found in: ./{input_directory}/{code_name}_postcrispr.fasta\n")

                #print the first sequence of the organism
                first_sequence = get_first_sequence(f"{input_directory}/{code_name}_postcrispr.fasta")
                report_file.write(f"\nThe first sequence of {code_name} is:\n{first_sequence}\n\n")

def get_clinical_data(clinical_data_file, code_name):
    # Function to extract clinical data for a given code_name from the clinical_data.txt file
    with open(clinical_data_file, "r") as data_file:
        for line in data_file:
            fields = line.strip().split("\t")
            if len(fields) >= 6 and fields[5] == code_name:
                return fields[0], int(fields[2]), fields[4], fields[1], fields[3], fields[5]

    # Return placeholder values if code_name is not found
    return "Unknown", 0, "Unknown", "Unknown", "Unknown", "Unknown"

def get_first_sequence(file_path):
    # Function to extract the first sequence from the FASTA file
    with open(file_path, "r") as fasta_file:
        header = None
        sequence = ""

        for line in fasta_file:
            if line.startswith(">"):
                if header is not None:
                    break
                header = line.strip()
            else:
                sequence += line.strip()

        return f"{header}\n{sequence}"

if __name__ == "__main__":
    generate_report()
