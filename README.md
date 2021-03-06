# Hartree-Fock Implementation: Fortran90

MENG 25510: Quantum Molecular and Materials Modeling -  Final Project 

University of Chicago, Spring 2022

Primary Authors: **Sullivan Fitz**, **Noah Dohrmann**

### Scale of Project

This is a short project in Fortran90+ to perform the Hartree-Fock (HF)
Self-Consistent Field (SCF) procedure on HeH+ that was optimized at the
CCSD/aug-cc-pVTZ level of theory using Gaussian16. The HF procedure was
performed using the 6-311G basis set for He and H. The result
of our code is then compared to both the PySCF energy for HF with the same
basis set, as well as the higher-quality energy attained at CCSD/aug-cc-pVTZ.

### Notes on Compatibility

Some of the code in these files requires UNIX commands (eg. "wc" for counting
file lines), and may not work if run without them.

For linear algebra functionality, C++/Eigen is used, so it is assumed that you
have a C++ compiler and it has access to the Eigen library header files.  If
you don't have the header files,  then run either of the below commands
depending if you are on a Mac or are on Linux (Midway preferred)
``./mac_eigen.sh`` or ``./midway_eigen.sh``.  These will install the necessary
files via git.  **Please make sure to do this *before* running the build
script.** Then, inside the cloned directory, run one of the following
commands: ``./mac_build.sh`` or ``./midway_build.sh`` to build and execute the
project. The results of the SCF procedure will be written to file in
`hf_out.out`.


### References

#### PySCF
Recent developments in the PySCF program package, Q. Sun, X. Zhang, S.
Banerjee, P. Bao, M. Barbry, N. S. Blunt, N. A. Bogdanov, G. H. Booth, J.
Chen, Z.-H. Cui, J. J. Eriksen, Y. Gao, S. Guo, J. Hermann, M. R. Hermes, K.
Koh, P. Koval, S. Lehtola, Z. Li, J. Liu, N. Mardirossian, J. D. McClain, M.
Motta, B. Mussard, H. Q. Pham, A. Pulkin, W. Purwanto, P. J. Robinson, E.
Ronca, E. R. Sayfutyarova, M. Scheurer, H. F. Schurkus, J. E. T. Smith, C.
Sun, S.-N. Sun, S. Upadhyay, L. K. Wagner, X. Wang, A. White, J. Daniel
Whitfield, M. J. Williamson, S. Wouters, J. Yang, J. M. Yu, T. Zhu, T. C.
Berkelbach, S. Sharma, A. Yu. Sokolov, and G. K.-L. Chan, J. Chem. Phys. 153,
024109 (2020)

PySCF: the Python-based simulations of chemistry framework, Q. Sun, T. C.
Berkelbach, N. S. Blunt, G. H. Booth, S. Guo, Z. Li, J. Liu, J. McClain, S.
Sharma, S. Wouters, and G. K.-L. Chan, WIREs Comput. Mol. Sci. 8, e1340 (2018)


#### Gaussian 16

Gaussian 16, Revision C.01, Frisch, M. J.; Trucks, G. W.; Schlegel, H. B.;
Scuseria, G. E.; Robb, M. A.; Cheeseman, J. R.; Scalmani, G.; Barone, V.;
Petersson, G. A.; Nakatsuji, H.; Li, X.; Caricato, M.; Marenich, A. V.;
Bloino, J.; Janesko, B. G.; Gomperts, R.; Mennucci, B.; Hratchian, H. P.;
Ortiz, J. V.; Izmaylov, A. F.; Sonnenberg, J. L.; Williams-Young, D.; Ding,
F.; Lipparini, F.; Egidi, F.; Goings, J.; Peng, B.; Petrone, A.; Henderson,
T.; Ranasinghe, D.; Zakrzewski, V. G.; Gao, J.; Rega, N.; Zheng, G.; Liang,
W.; Hada, M.; Ehara, M.; Toyota, K.; Fukuda, R.; Hasegawa, J.; Ishida, M.;
Nakajima, T.; Honda, Y.; Kitao, O.; Nakai, H.; Vreven, T.; Throssell, K.;
Montgomery, J. A., Jr.; Peralta, J. E.; Ogliaro, F.; Bearpark, M. J.; Heyd, J.
J.; Brothers, E. N.; Kudin, K. N.; Staroverov, V. N.; Keith, T. A.; Kobayashi,
R.; Normand, J.; Raghavachari, K.; Rendell, A. P.; Burant, J. C.; Iyengar, S.
S.; Tomasi, J.; Cossi, M.; Millam, J. M.; Klene, M.; Adamo, C.; Cammi, R.;
Ochterski, J. W.; Martin, R. L.; Morokuma, K.; Farkas, O.; Foresman, J. B.;
Fox, D. J. Gaussian, Inc., Wallingford CT, 2016.

#### Dunning Basis Sets
J. Chem. Phys. 90, 1007 (1989); https://doi.org/10.1063/1.456153
J. Chem. Phys. 103, 4572 (1995); https://doi.org/10.1063/1.470645

#### Krishnan 6-311G Basis Set (He)
J. Chem. Phys. 72, 650-654 (1980); https://doi.org/10.1063/1.438955

#### BSE
Pritchard, Benjamin P., Altarawy, Doaa, Didier, Brett, Gibsom, Tara
            D., Windus, Theresa L.
    A New Basis Set Exchange: An Open, Up-to-date Resource for the
            Molecular Sciences Community
    J. Chem. Inf. Model. 59, 4814-4820 (2019)
    10.1021/acs.jcim.9b00725
   
 Feller, David
    The role of databases in support of computational chemistry
            calculations
    J. Comput. Chem. 17, 1571-1586 (1996)
    10.1002/(SICI)1096-987X(199610)17:13<1571::AID-JCC9>3.0.CO;2-P
    
Schuchardt, Karen L., Didier, Brett T., Elsethagen, Todd, Sun, Lisong,
            Gurumoorthi, Vidhya, Chase, Jared, Li, Jun, Windus, Theresa L.
    Basis Set Exchange: A Community Database for Computational Sciences
    J. Chem. Inf. Model. 47, 1045-1052 (2007)
    10.1021/ci600510j

#### Avogadro

https://avogadro.cc/
