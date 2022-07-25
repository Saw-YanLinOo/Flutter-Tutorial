void main() {
  Map<int, String> nameMap = {1: "Mg Mg"};
  print(nameMap.toString());

  //Reading data from a map
  print(nameMap[1]);

  //Adding data into a map
  nameMap[2] = 'John';
  print(nameMap.toString());

  //Adding data into a map with same key
  nameMap[2] = 'Mary';
  print(nameMap.toString());

  //Remove data from map
  nameMap.remove(1);
  print(nameMap.toString());

  //Attributes
  print(nameMap.length);
  print(nameMap.isEmpty);
  print(nameMap.isNotEmpty);

  //Getting keys and values
  print(nameMap.keys);
  print(nameMap.values);

  //Contains keys or values
  print(nameMap.containsKey(1));
  print(nameMap.containsValue('Mg Mg'));
}
