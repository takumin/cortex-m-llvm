extern int i;
void main(void);

int i = 10;
void main(void) {
  // 20170827 ld.lld 5.0.0 segfault
  // int i = 10;

  for (int k = 0; k < i; k++)
    k = i;
}
