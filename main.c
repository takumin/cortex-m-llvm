extern const int i;
extern int j;
extern int m;
extern int dtcm;
extern void main(void);
extern void itcm(void);

const int i = 10;
int j = 10;
int m;

void main(void) {
  itcm();
  for (int k = 0; k < i; k++) {
    j = i + k;
    m = j;
  }
}

__attribute__((section(".dtcm"))) int dtcm;

__attribute__((section(".itcm"))) void itcm(void) {
  for (int k = 0; k < i; k++) {
    j = i + k;
    dtcm = j;
  }
}
