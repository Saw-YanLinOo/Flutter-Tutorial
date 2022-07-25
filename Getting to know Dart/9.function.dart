String animal = 'Snake';

void main() {
  saySomething();
  checkIfAnimalIsSnake();

  bool isSnake = checkIfAnimalIsSnakePure(animal);
  print(isSnake);

  print(
    sum(
      firstNum: 3,
    ),
  );

  printName();
  printName('Say Name');
}

void saySomething() {
  print("Something");
}

void checkIfAnimalIsSnake() {
  print(animal == 'Snake');
}

bool checkIfAnimalIsSnakePure(String animal) {
  return animal == 'Snake';
}

int sum({required int firstNum, int secondNum = 3}) {
  return (firstNum * secondNum);
}

void printName([String? name]) {
  print(name);
}
