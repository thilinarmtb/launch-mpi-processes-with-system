#include <signal.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  system("mpirun -np 4 ./mpi &");

  return 0;
}
