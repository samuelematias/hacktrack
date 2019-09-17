import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  final tokenController = BehaviorSubject<String>();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    tokenController.close();
    super.dispose();
  }
}
