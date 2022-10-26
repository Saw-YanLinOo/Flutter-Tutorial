void main() async {
  Stream<int> numberStream =
      Stream.fromIterable([1, 2, 3, 4, 5, 6]).asBroadcastStream();

  // Filtering operator
  // Where
  numberStream.where((number) => number % 2 == 0).listen((event) {
    print(event);
  });

  // First Where
  numberStream.firstWhere((number) => number % 2 == 0).then((event) {
    print(event);
  });
  // Last Where
  numberStream.lastWhere((number) => number % 2 == 0).then((event) {
    print(event);
  });

  // Conditional Operator
  // Take
  numberStream.take(5).listen((number) {
    print(number);
  });
  // Take While
  numberStream.takeWhile((number) => number < 5).listen((number) {
    print(number);
  });
  // Skip
  numberStream.skip(5).listen((number) {
    print(number);
  });
  // Skip While
  numberStream.skipWhile((number) => number < 5).listen((number) {
    print(number);
  });

  // Transformation Operator
  // Map
  numberStream.map((number) => number * 2).listen((number) {
    print(number);
  });

  // Async Expand
  Stream<List<int>> numberListStream = Stream.value([1, 2, 3, 4, 5, 6, 7]);
  numberListStream
      .asyncExpand((numberList) => Stream.fromIterable(numberList))
      .where((event) => event % 2 == 0)
      .map((number) => number * 2)
      .listen((number) {
    print(number);
  });

  // Operator that product a single value
  // Join
  numberStream.join(',').then((joinStream) => print(joinStream));

  // Reduce
  numberStream
      .reduce((previous, element) => previous + element)
      .then((value) => print(value));

  // ToList
  numberStream.toList().then((value) => print(value));

  // ToSet
  numberStream.toSet().then((value) => print(value));
}
