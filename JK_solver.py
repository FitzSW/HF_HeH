#! /usr/bin/python3

import numpy as np
import pyscf
from pyscf import gto, scf
import os


""" 
A script to help find J and K at each step of the SCF loop
"""

# The current density matrix
P_file = "P_out"

P = np.array(np.loadtxt(P_file))


# Perform RHF 
mol = gto.M(atom='H 0 0 -0.517427; He 0 0 0.258713', charge=1,basis = '6-311G')

mf = scf.hf.SCF(mol)
mf.verbose = 0
mf.level_shift = .4
en = mf.scf()

# These J and K include P in their definition, unlike in
# Szabo and Ostlund
J, K = scf.hf.get_jk(mol,P)

O = J + K

# J_out = "./J"
# K_out = "./K"
O_out = "./JK"

np.savetxt(O_out,O)
# np.savetxt(K_out,K)

os.system(f"rm -f {P_file}")
