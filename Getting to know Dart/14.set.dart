void main() {
  //Creating a set
  Set<int> numberSet = {1, 2, 3, 4, 5};
  print(numberSet.toString());

  //Creating a set with duplicated
  Set<int> duplicatedSet = {1, 1, 1, 3, 3, 4, 5, 5};
  print(duplicatedSet.toString());

  //Contains
  print(numberSet.contains(1));

  //Adding Data
  numberSet.add(6);
  print(numberSet.toString());

  //Remove
  numberSet.remove(4);
  print(numberSet.toString());

  //Adding list to set
  List<int> numberList = [7, 8, 9, 9, 10];
  numberSet.addAll(numberList);
  print(numberSet.toString());

  //Intersection
  Set<int> secondNumSet = {6, 7, 8, 9, 9, 9, 10, 11, 12};
  print(numberSet.intersection(secondNumSet));

  //Union
  print(numberSet.union(secondNumSet));
}
