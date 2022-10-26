void main() async {
  Future<String> nameFuture = Future.value('Yan Yan');
  nameFuture.then((name) => print(name));

  Future<List<int>> numberListFuture = Future.value([1, 2, 3, 4, 5, 6]);
  numberListFuture.then((number) => print(number));

  Future<String> errorFuture = Future.error(NullThrownError());
  errorFuture.then((value) => print(value)).catchError((err) => print(err));

  Future<String> delayedNameFuture =
      Future.delayed(const Duration(seconds: 3), () => 'Yan Yan');
  delayedNameFuture.then((value) => print(value));

  Future<String> padcFuture =
      Future.delayed(const Duration(seconds: 3), () => 'PADC Myanmar');
  String padc = await padcFuture;
  print(padc);

  Future<String> threeSecondFuture =
      Future.delayed(const Duration(seconds: 3), () => '3 seconds future');
  Future<String> twoSecondFuture =
      Future.delayed(const Duration(seconds: 3), () => '2 seconds future');
  Future<String> oneSecondFuture =
      Future.delayed(const Duration(seconds: 3), () => '1 seconds future');

  print(await threeSecondFuture);
  print(await twoSecondFuture);
  print(await oneSecondFuture);

  Future<String> errFuture = Future.error(NullThrownError());
  try {
    String value = await errFuture;
  } catch (e) {
    print(e.toString());
  }
}
