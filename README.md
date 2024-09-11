Introduction
============

This repo contains an example which launches MPI processes using `system()`
command within a serial (non-MPI) program. Once the MPI processes are launched,
the serial program exits.

Build the examples
==================

Need to have CMake and MPI installed in your system. Then you can build the
binaries using `testmpi.sh`.

```sh
./testmpi.sh
```

Do `./testmpi.sh -- help` to see all the available options.

Run the example
===============

By default, the binaries get installed in `${PWD}/install/bin`.
You can run the example by doing:

```sh
cd install/bin
./serial
```

You can see (using a tool like `top`) that the `mpi` programs are still running
even after the `serial` program exits.
