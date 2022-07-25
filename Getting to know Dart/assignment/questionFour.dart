void main() {
  Map<String, int?> map = {
    '1': 1,
    '2': 2,
    '3': 3,
    '4': null,
    '5': 5,
    '6': null,
    '7': 7,
    '8': 8,
  };

  print(map.values.where((element) => element != null).toString());
}
