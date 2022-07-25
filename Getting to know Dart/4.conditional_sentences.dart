void main() {
  int number = 60;

  if (number < 50) {
    print('Number is less than 50');
  } else if (number >= 50 && number < 70) {
    print('Number is between 50 and 70');
  } else {
    print('Number is greater than 70');
  }

  var firstNum = 40;
  var secondNum = 50;

  var thirdNum = (firstNum > secondNum) ? firstNum : secondNum;
  print(thirdNum);
}
