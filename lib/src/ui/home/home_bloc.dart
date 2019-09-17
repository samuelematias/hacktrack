import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class HomeBloc extends BlocBase {
  int counter = 0;

  StreamController<int> _counterController =
      new StreamController<int>.broadcast();

  Function(int) get addCounter => _counterController.sink.add;

  Stream<int> get counterValue => _counterController.stream;

  increment() {
    addCounter(++counter);
  }

  @override
  void dispose() {
    super.dispose();
    _counterController?.close();
  }
}
