void main() {
  var nullableValue;
  print(nullableValue);

  //Non-Nullable data Type
  String name = 'My Name';
  print(name);

  //Optional or Nullabel data Type
  String? height;
  int? age;
  print(height);

  // ??
  String heightToPrint = height ?? '20';
  print(heightToPrint);

  // ??=
  age ??= 20;
  print(age);

  //Null safty operator - ?
  String? school;
  print(school?.toLowerCase());
}
