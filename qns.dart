// ignore_for_file: avoid_print

void main(List<String> args) {
  factorial(4);
}

int fact(int n) {
  if (n == 0) {
    return 1;
  } else {
    return n * fact(n - 1);
  }
}

void factorial(int n) {
  int fact = 0;
  for (int i = 0; i < n-1; i++) {
    if (n != 0) {
      fact += n * (n - 1);
    }
  }
  print(fact);
}
