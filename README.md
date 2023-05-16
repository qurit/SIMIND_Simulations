# SIMIND Simulation Scripts

The scripts contained in this repository are used to run SIMIND simulation on XCAT phantom data. The files are as follows:

* `simind.smc` controls the simulation parameters of the SIMIND Monte Carlo program. This file, however, is not to be editted by the user. Rather, once SIMIND is installed, one should use the `change` command to edit this file, which will automatically detect the `simind.smc` file in the current directory. It's important to understand every flag in this file by reading the SIMIND manual.

* `run_one.sh` is a bash script that runs a SIMIND simulation for a given organ of the XCAT phantom.

* `run_all_organs.sh` is a bash script that runs `run_one.sh` for a specified list of organs.

* `run_all_lesions.sh` is similar to the above.

* `run_calibration.sh` is similar to `run_one.sh`, but it doesn't save any data. It's primary purpose is to determine a calibration factor which allows one to convert from counts per second (cps) to MBq per mL (MBq/mL). This information is contained in line 128 of the output `.res` file. This can be done for any organ/lesion, though it is typically done with a small volume near the center of the object space.

* `scattwin.win` specifies the different energy windows of the Monte Carlo simulation. See the SIMIND user's manual.

* `add_together.py` is a python script that is used to add together the results of the many parallel simulation jobs. It is called during the `run_one.sh` script.