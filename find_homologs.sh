#! /bin/bash
# usage: ./find_perfect_matches.sh <query file> <subject file> <output file>

queryfile="$1"
subjectfile="$2"
outputfile="$3"

blastn -query "$queryfile" -subject "$subjectfile" -task blastn-short -outfmt "6 std sseq qlen" -out "$outputfile"

# get length of query sequence
query_length=$(awk '/^>/ {next} {seq = seq $0} END {print length(seq)}' "$queryfile")

# filter results to same length as query length and write to another file
awk -F"\t" '{if ($4 == '"$query_length"') print}' "$outputfile" > "${outputfile}_filtered_samelength"

# count number of perfect matches
perfectmatch_count=$(cat "${outputfile}_filtered_samelength" | wc -l)

echo "Number of perfect matches: $perfectmatch_count"


# added qlen field to blastn command
# removed -perc_identity 100