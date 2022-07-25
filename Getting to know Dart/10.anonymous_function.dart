void main() {
  sayHello();
  print(doubleIt(2));

  List<int> numberList = [1, 2, 3, 4, 5];
  numberList.forEach((element) => print(element));
}

Function sayHello = () => print('Hello');

Function(int) doubleIt = (number) => number + 2;
