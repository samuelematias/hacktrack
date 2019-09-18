import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class TeamBloc extends BlocBase {
  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
  }
}
