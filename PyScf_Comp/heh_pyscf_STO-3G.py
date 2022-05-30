#! /usr/bin/python3

"""
A comparative calculation done on the same Helium Hydride geometry with the 
same basis set (STO-3G) 
"""

import pyscf
from pyscf import gto, scf

mol = gto.M(atom='H 0 0 -0.517427; He 0 0 0.258713', charge=1,basis = 'STO-3G')
            
mf = scf.hf.SCF(mol)
mf.verbose = 0
mf.level_shift = .4
en = mf.scf()

output_loc = "STO-3G_energy"

with open(output_loc,"w") as f:
    f.write(str(en))
