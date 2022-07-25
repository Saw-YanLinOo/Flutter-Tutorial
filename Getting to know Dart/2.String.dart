void main() {
  String name = 'Mg Mg';
  print(name);

  var school = 'School';
  print(school);

  String quote = 'Welcome to Wold\nFlutter developer';
  print(quote);

  String rawString = r"This is raw String \n doesn't work";
  print(rawString);

  int apple = 5;
  int mangoes = 4;

  print('There are $apple apples and $mangoes mangoes');
  print('Total fruit = ${apple + mangoes}');

  int oranges = int.parse('6');
  print(oranges);

  double floadingNum = double.parse('3.14');
  print(floadingNum);

  int.parse('Not possible');
  
}
