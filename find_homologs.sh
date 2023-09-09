#! /bin/bash
# usage: ./find_perfect_matches.sh <query file> <subject file> <output file>

queryfile="$1"
subjectfile="$2"
outputfile="$3"

tblastn -query "$queryfile" -subject "$subjectfile" -outfmt "6 std sseq qlen" -out "$outputfile"

# get length of query sequence
query_length=$(awk '/^>/ {next} {seq = seq $0} END {print length(seq)}' "$queryfile")

# calculate 90% of the query length
ninety_perc_query_length=$((query_length * 90 / 100))

# filter results to > 90% query length and > 30% identity
awk -F"\t" '{if ($4 > '"$ninety_perc_query_length"' && $3 > 30.000) print}' "$outputfile" > "${outputfile}_filtered"

# count number of perfect matches
match_count=$(cat "${outputfile}_filtered" | wc -l)

echo "Number of matches: $match_count"


# added qlen field to blastn command
# removed -perc_identity 100

# changed blastn to tblastn

# calculated 90% of query length and stored as variable
# awk filter - alignment length must be > 90% query length
# awk filter - only > 30.000 seq identity

# what to do for task??