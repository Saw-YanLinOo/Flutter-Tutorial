void main() {
  //Spread Operator
  var firstNumList = [1, 2, 3, 4, 5];
  var secondNumList = [5, 6, 7, 8, 9];
  var thirdNumList = [...firstNumList, ...secondNumList];
  print(thirdNumList);

  //Map
  var doubledList = thirdNumList.map((e) => e * 2);
  print(doubledList.toString());

  //Where
  var evenList = thirdNumList.where((element) => element.isEven);
  print(evenList);

  //Reduce
  var total = thirdNumList.reduce((value, element) => value + element);
  print(total);

  //Operator Chaining
  var result = thirdNumList
      .map((e) => e * 3)
      .where((element) => element.isOdd)
      .reduce((value, element) => value + element);
  print(result);
}
