import 'dart:isolate';

void main(List<String> args) async {
  Isolate.spawn(a, "A FUNC");
  Isolate.spawn(b, "B FUNC");
  Isolate.spawn(c, "C FUNC");
  print("Hello1");
  print("Hello2");
}

a(String msg) => print(msg);

b(String msg) => print(msg);


c(String msg) => print(msg);

