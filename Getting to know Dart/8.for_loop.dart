void main() {
  //Traditional For Loop
  var number = 1;

  for (var i = 1; i < 10; i++) {
    print(number);
    number++;
  }

  //For in Loop
  var numbers = [1, 2, 3, 4, 5];
  for (var num in numbers) {
    print(num);
  }
}
