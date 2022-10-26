void main() async {
  Stream<int> numberStream =
      Stream.fromIterable([1, 2, 3, 4, 5, 6]).asBroadcastStream();
  numberStream.listen((event) {
    print(event);
  });
  numberStream.listen((event) {
    print('${event + 1}');
  });

  Stream<List<int>> numberListStream = Stream.value([1, 2, 3, 4, 5, 6]);
  numberListStream.listen((event) {
    print(event);
  });

  Stream<int> errorSteam = Stream.error(NullThrownError());
  errorSteam.listen((event) {}).onError((err) => print(err.toString()));
}
