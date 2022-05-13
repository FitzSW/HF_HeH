### A Note on Module Use

Modules, eg "m.f90" must be compiled to "m.mod" files before they are used.
Then, in another file, write "use m" at the top of the file to gain access to
the module. When compiling, do "gfortran main.f90 m.f90" to link the two files
together and to produce an executable that works.
