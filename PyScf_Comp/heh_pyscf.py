#! /home/ndohrmann/.conda/envs/local/bin/python3

"""
A comparative calculation done on the same methane geometry with the 
same basis set (6-311G) 
"""

import pyscf
from pyscf import gto, scf

mol = gto.M(atom='H 0 0 -0.517427; He 0 0 0.258713', charge=1,basis = '6-311G')
            
mf = scf.hf.SCF(mol)
mf.verbose = 0
mf.level_shift = .4
en = mf.scf()

output_loc = "/project/lgagliardi/ndohrmann/Desktop/M25510/PySCF_Comp/pyscf_out"

with open(output_loc,"w") as f:
    f.write(str(en))
