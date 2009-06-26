#/bin/bash
#Makefile for pySpline

#First make the source files for the real version
cd src

make

cd ../

#Now f2py just the functions we need in the pyf
f2py  --fcompiler=gfortran --f90flags=-r8 -c -m pyspline src/pyspline.pyf src/libtensbs.a -llapack

#Now make the source files for the complex version

mv pyspline.so ./python

# cd src_cs

# make

# cd ../

# f2py  --fcompiler=intel --f90flags=-r8 -I./src_cs -c -m pyspline_cs src_cs/pyspline_cs.pyf src_cs/libtensbs_cs.a 
# mv pyspline_cs.so ./python