#include <stdlib.h>
#include <signal.h>

int main(int argc, char *argv[]) {
  system("mpirun -np 4 ./mpi &");

  return 0;
}
