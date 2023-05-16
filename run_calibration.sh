data_path=../phantom_organs
act_file=liver
atn_file=noatten
path=calibrations1
n_jobs=90

scp ${data_path}/${act_file}_act_av.bin .
scp ${data_path}/${atn_file}_atn_av.bin .

sed -i "s~xxatnfilexx~$atn_file~g" simind.smc
sed -i "s~xxactfilexx~$act_file~g" simind.smc

for i in $(seq 1 $n_jobs)
do
    simind simind temp_output${i}/fi:lu177/in:x22,5x &
done
wait

rm ${act_file}_act_av.bin
rm ${atn_file}_atn_av.bin
sed -i "s~$atn_file~xxatnfilexx~g" simind.smc
sed -i "s~$act_file~xxactfilexx~g" simind.smc

# move all calibrations to folder
mkdir ${path}
mv *.res ${path}
rm -rf temp*