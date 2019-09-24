import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/join_model.dart';
import 'join_repository.dart';

class JoinBloc extends BlocBase {
  final JoinRepository repo;

  JoinBloc(this.repo);

  String joinCode;

  static var storageService = locator<AppPreferencesService>();

  var _isShowLoading = BehaviorSubject<bool>();

  var getValidateCode = BehaviorSubject<JoinModel>();
  JoinModel get getValidateCodeOut => getValidateCode.value;
  Sink<JoinModel> get getValidateCodeIn => getValidateCode.sink;

  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _joinCodeStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateJoinStreamController =
      new StreamController<String>.broadcast();

  Function(String) get addJoinCode => _joinCodeStreamController.sink.add;

  Stream<String> get getJoinCode => _joinCodeStreamController.stream;

  Function(String) get addValidateJoin =>
      _validateJoinStreamController.sink.add;

  Stream<String> get getValidateJoin => _validateJoinStreamController.stream;

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _joinCodeStreamController?.close();
    _validateJoinStreamController?.close();
    _isShowLoading?.close();
    getValidateCode?.close();
  }

  void validateCode() async {
    try {
      _isShowLoading.add(true);
      var response =
          await repo.validateCode(JoinModel(code: joinCode).toJson());

      if (response.status == "ok") {
        _isShowLoading.add(false);
        getValidateCodeIn.add(response);
        storageService.setHackathonId(response.id);
        storageService.setHackathonIdentifier(response.identifier);
        storageService.setHackathonName(response.name);
        storageService.setIsUserLogged(response.isMentor);
        storageService.setIsMentor(response.isMentor);
        storageService.setIsAccessByCode(true);
      } else {
        _isShowLoading.add(false);
        getValidateCode.addError(226);
      }
    } catch (e) {
      _isShowLoading.add(false);
      getValidateCode.addError(404);
    }
  }

  updateJoinCode(String text) {
    addJoinCode(
      text.isEmpty ? null : text.trim().length > 0 ? text : null,
    );
    //handle errors:
    // (text == null || text == "")
    //     ? _textController.sink.addError("Invalid value entered!")
    //     : _textController.sink.add(text);
  }

  validateJoinButton(String joinCode) {
    final bool joinCodeIsValid =
        joinCode.isEmpty ? false : joinCode.trim().length > 0 ? true : false;

    addValidateJoin(joinCodeIsValid ? "ok" : "nok");
  }
}
