#include <interval.xh>
#include <stdio.h>

int main (int argc, char **argv) {
  interval a = intr[0, 10];
  interval b = {3, 17};
  interval c = a + b;
  interval d = a - b;
  interval e = a * b;
  interval f = a / b;
  interval g = -c;
  interval h = ~d;

  printf("a: %s\n", show(a).text);
  printf("b: %s\n", show(b).text);
  printf("c: %s\n", show(c).text);
  printf("d: %s\n", show(d).text);
  printf("e: %s\n", show(e).text);
  printf("f: %s\n", show(f).text);
  printf("g: %s\n", show(g).text);
  printf("h: %s\n", show(h).text);

  if (a != intr[0, 10])
    return 1;
  if (c != intr[3, 27])
    return 2;
  if (d != intr[-17, 7])
    return 3;
  if (e != intr[0, 51])
    return 4;
  if (f != (interval){0.000000, 10/17.0})
    return 5;
  if (g != (interval){-27, -3})
    return 6;
  if (h != (interval){1/7.0, -1/17.0})
    return 7;
  
  return 0; 
}
