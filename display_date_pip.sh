local=$(date +%r)
unix=$(date +%s)

echo "Unix:   $unix\nLocal: $local" | tee -a unixtimes.txt
