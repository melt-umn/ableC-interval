#include <interval.xh>
#include <stdio.h>

int main (int argc, char **argv) {
  interval a = intr[0, 10];
  interval b = intr[3, 17];
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
  
  return 0; 
}
