current_time=$(date +%s)


label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

for i in $(seq $num_reps); do
    duckdb "$db_file" "$query"
done

new_time=$(date +%s)
elapsed=$((new_time - current_time))
time_per_query=$(python -c "print($elapsed/$num_reps)")

output="$label,$time_per_query"
echo "$output" >> "$csv_file"