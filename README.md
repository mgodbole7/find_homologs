# find_homologs
# Given a protein sequence query, perform a blast search against a nucleotide subject.
# Filter hits to keep only hits with >30% sequence identity and >90% match length (90% of the query sequence length) 
# Output matches to a specified file (this script outputs two files, one with all matches, then one with filtered matches)
# Print the number of matches identified
# Usage of your script: ./find_homologs.sh <query file> <subject file> <output file> 
