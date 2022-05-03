#! /home/ndohrmann/.conda/envs/local/bin/python3

"""
A comparative calculation done on the same methane geometry with the 
same basis set (cc-pVTZ) 
"""

import pyscf
from pyscf import gto, scf

mol = gto.M(atom='C 0 0 0; H 1.032996   -0.315832    0.133490; H -0.534124   -0.097985    0.943271; H -0.476072   -0.625125   -0.753143; H -0.022800    1.038942   -0.323618', basis = 'cc-pvtz')
            
            
mf = scf.hf.SCF(mol)
mf.verbose = 0
mf.level_shift = .4
en = mf.scf()

output_loc = "<DIR>" # hidden for privacy 

with open(output_loc,"w") as f:
    f.write(str(en))
