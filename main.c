extern const int i;
extern int j;
extern int m;
extern void main(void);

const int i = 10;
int j = 10;
int m;
void main(void) {
  for (int k = 0; k < i; k++) {
    j = i + k;
    m = j;
  }
}
