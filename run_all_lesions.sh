for i in 1 2 3 4 5 6 7 8; do
    for j in 2 4 6 8 10 12 14 16; do
        bash run_one.sh lesion${i}_${j}mm
    done
done