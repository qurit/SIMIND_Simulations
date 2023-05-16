import numpy as np
import sys
import os

n_files = int(sys.argv[1])
path = sys.argv[2]
 
xtot_w1 = 0
xtot_w2 = 0
xtot_w3 = 0
xprimary_w2 = 0 
for i in range(1, n_files+1):
    w1 = np.fromfile(os.path.join(path, f'temp_output{i}_tot_w1.a00'), dtype=np.float32)
    w2 = np.fromfile(os.path.join(path, f'temp_output{i}_tot_w2.a00'), dtype=np.float32)
    w2_sca = np.fromfile(os.path.join(path, f'temp_output{i}_sca_w2.a00'), dtype=np.float32)
    w3 = np.fromfile(os.path.join(path, f'temp_output{i}_tot_w3.a00'), dtype=np.float32)
    xtot_w1+=w1
    xtot_w2+=w2
    xtot_w3+=w3
    xprimary_w2+=w2-w2_sca
xtot_w1 = xtot_w1 / n_files # since it gives in probability
xtot_w2 = xtot_w2 / n_files
xtot_w3 = xtot_w3 / n_files
xprimary_w2 = xprimary_w2 / n_files

xtot_w1.tofile(os.path.join(path, f'lowerscatter.a00'))
xtot_w2.tofile(os.path.join(path, f'photopeak.a00'))
xprimary_w2.tofile(os.path.join(path, f'primary.a00'))
xtot_w3.tofile(os.path.join(path, f'upperscatter.a00'))