import 'dart:async';

void main() {
  StreamController<List<int>> numberStreamController = StreamController();

  // Widget
  numberStreamController.stream.listen((event) => print(event));

  // Blocs
  numberStreamController.sink.add([1, 2, 3, 4, 5]);
  numberStreamController.sink.add([6, 7, 8, 9]);

  // Widget onDispose
  numberStreamController.close();

  numberStreamController.sink.add([1, 2, 3, 4, 5]);
}
