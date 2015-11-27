```python

mpif90 myprog.f90
mpirun -np 2 ./a.out
```

==============
```python
mpif90 myprog.f90 -o kaikai
mpirun -np 2 ./kaikai
```

==============

```python
icc/ifort、
pgcc/pgf90、
gcc/gfortran
```

===============



MPI 
FORTRAN90 Examples

MPI is a directory of FORTRAN90 programs which illustrate the use of the MPI Message Passing Interface.

MPI allows a user to write a program in a familiar language, such as C, C++, FORTRAN, or Python, and carry out a computation in parallel on an arbitrary number of cooperating computers.

Overview of MPI

A remarkable feature of MPI is that the user writes a single program which runs on all the computers. However, because each computer is assigned a unique identifying number, it is possible for different actions to occur on different machines, even though they run the same program:

```
        if ( I am processor A ) then
          add a bunch of numbers
        else if ( I am processor B ) then
          multipy a matrix times a vector
        end
      
```
Another feature of MPI is that the data stored on each computer is entirely separate from that stored on other computers. If one computer needs data from another, or wants to send a particular value to all the other computers, it must explicitly call the appropriate library routine requesting a data transfer. Depending on the library routine called, it may be necessary for both sender and receiver to be "on the line" at the same time (which means that one will probably have to wait for the other to show up), or it is possible for the sender to send the message to a buffer, for later delivery, allowing the sender to proceed immediately to further computation.

Here is a simple example of what a piece of the program would look like, in which the number X is presumed to have been computed by processor A and needed by processor B:


```
        if ( I am processor A ) then
          call MPI_Send ( X )
        else if ( I am processor B ) then
          call MPI_Recv ( X )
        end
```

Often, an MPI program is written so that one computer supervises the work, creating data, issuing it to the worker computers, and gathering and printing the results at the end. Other models are also possible.

It should be clear that a program using MPI to execute in parallel will look much different from a corresponding sequential version. The user must divide the problem data among the different processes, rewrite the algorithm to divide up work among the processes, and add explicit calls to transfer values as needed from the process where a data item "lives" to a process that needs that value.

A FORTRAN90 program, subroutine or function must include the line


```

        use mpi

```


so that the various MPI functions and constants are properly defined. (If this use statement doesn't work, you may have to fall back on using the FORTRAN77 include file instead:


```
        include "mpif.h"
```


You probably compile and link your program with a single command, as in

```
        f90 myprog.f90
```


Depending on the computer that you are using, you may be able to compile an MPI program with a similar command, which automatically locates the include file and the compiled libraries that you will need. This command is likely to be:
```python
        mpif90 myprog.f90
```      
Interactive MPI Runs

Some systems allow users to run an MPI program interactively. You do this with the mpirun command:
```python

        mpirun -np 4 a_output.txt
```      
This command requests that the executable program` a_output.txt `be run, right now, using` 4 processors`.
The mpirun command may be a convenience for beginners, with very small jobs, but this is not the way to go once you have a large lengthy program to run! Also, what actually happens can vary from machine to machine. When you ask for 4 processors, for instance,

in the best case, mpirun automatically finds three other machines just like the one you are one, copies your program to them, and starts your program on all four.
in a less good case, there are four processors on your current machine, so the memory is divided up among them and your program runs;
in a worse case, there are less than four processors available, so, as necessary, one processor will "time share", and run two or more of your processes alternately.
