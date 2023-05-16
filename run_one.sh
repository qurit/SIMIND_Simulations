data_path=../phantom_organs # where to get XCAT data from
act_file=$1 #name of activity file minus "_act_av.bin" (in the data_path directory)
atn_file=mu208 #name of attenuation file (in the data_path directory)
path=sim_files/$act_file #name of directory where to save the files
n_jobs=90 #change if you have less CPU cores

# Copy XCAT binary files to current directory
scp ${data_path}/${act_file}_act_av.bin .
scp ${data_path}/${atn_file}_atn_av.bin .

# Change simind.smc so that attenuation file and activity file
# correspond to the arguments in lines 2 and 3
sed -i "s~xxatnfilexx~$atn_file~g" simind.smc
sed -i "s~xxactfilexx~$act_file~g" simind.smc

# Run all simulations in parallel
for i in $(seq 1 $n_jobs)
do
    simind simind temp_output${i}/fi:lu177/in:x22,5x &
done
wait

# Remove the XCAT binary files from the current directory
# and change the simind.smc back to it's original state.
rm ${act_file}_act_av.bin
rm ${atn_file}_atn_av.bin
sed -i "s~$atn_file~xxatnfilexx~g" simind.smc
sed -i "s~$act_file~xxactfilexx~g" simind.smc

# Make the path where the SIMIND simulation files are to be saved
mkdir $path
mv temp_output* $path

# Run python script to add together all parallel jobs
python add_together.py $n_jobs $path

# Move outputs of the python script to save directory, rename them,
# and modify the header files so that they refer to the renamed versions.
cd $path
mv temp_output1_tot_w1.h00 lowerscatter.h00
mv temp_output1_tot_w2.h00 photopeak.h00
mv temp_output1_tot_w3.h00 upperscatter.h00
mv temp_output1_sca_w2.h00 primary.h00
sed -i 's/temp_output1_tot_w1.a00/lowerscatter.a00/g' lowerscatter.h00
sed -i 's/temp_output1_tot_w2.a00/photopeak.a00/g' photopeak.h00
sed -i 's/temp_output1_tot_w3.a00/upperscatter.a00/g' upperscatter.h00
sed -i 's/temp_output1_sca_w2.a00/primary.a00/g' primary.h00
rm -rf temp*