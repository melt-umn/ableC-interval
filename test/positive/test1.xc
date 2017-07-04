#include <interval.xh>
#include <stdio.h>

void print_interval(interval x) {
  printf("[%f, %f]\n", x.min, x.max);
}

int main (int argc, char **argv) {
  interval a = intr[0, 10];
  interval b = intr[3, 17];
  interval c = a + b;
  interval d = a - b;
  interval e = a * b;
  interval f = a / b;
  interval g = -c;
  interval h = ~d;

  print_interval(a);
  print_interval(b);
  print_interval(c);
  print_interval(d);
  print_interval(e);
  print_interval(f);
  print_interval(g);
  print_interval(h);

  if (a != intr[0, 10])
    return 1;
  if (c != intr[3, 27])
    return 2;
  if (d != intr[-17, 7])
    return 3;
  if (e != intr[0, 51])
    return 4;
  if (f != intr[0.000000, 10/17.0])
    return 5;
  if (g != intr[-27, -3])
    return 6;
  if (h != intr[1/7.0, -1/17.0])
    return 7;
  
  return 0; 
}
