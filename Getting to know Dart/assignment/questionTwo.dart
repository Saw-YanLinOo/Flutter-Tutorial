void main() {
  Map<String, int> map = {
    '1': 1,
    '2': 2,
    '10': 10,
    '20': 20,
    '100': 100,
    '200': 200,
    '1000': 1000,
    '2000': 2000,
    '10000': 10000,
    '20000': 20000,
    '100000': 100000,
    '200000': 200000,
  };
  var total = 0;
  // map.forEach((key, value) {
  //   if (value > 10000) {
  //     total += value;
  //   }
  // });

  total = map.values
      .where((element) => element >= 10000)
      .reduce((value, element) => value + element);

  print(total);
}
