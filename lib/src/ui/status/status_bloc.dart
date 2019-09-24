import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../team/team_repository.dart';
import 'uploaderS3.dart';

class StatusBloc extends BlocBase {
  final TeamRepository repo;
  final UploadToS3 _uploadToS3;

  StatusBloc(this.repo, this._uploadToS3);

  String trackStage = "";
  String trackStatus = "";
  String trackComment = "";
  File photo1;
  List arrayPhotos = [];
  List<String> arrayPhotosLinkUploaded = [];

  static var storageService = locator<AppPreferencesService>();

  var _isShowLoading = BehaviorSubject<bool>();

  var getTracks = BehaviorSubject<List<TeamModel>>();
  Sink<List<TeamModel>> get getTracksIn => getTracks.sink;
  Observable<List<TeamModel>> get getTracksOut => getTracks.stream;

  var createTrackPost = BehaviorSubject<TeamModel>();
  TeamModel get createTrackPostValue => createTrackPost.value;
  Sink<TeamModel> get createTrackPostIn => createTrackPost.sink;

  var uploadPhotoPost = BehaviorSubject<TeamModel>();
  TeamModel get uploadPhotoPostValue => uploadPhotoPost.value;
  Sink<TeamModel> get uploadPhotoPostIn => uploadPhotoPost.sink;

  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _commentsStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateUpdateStreamController =
      new StreamController<String>.broadcast();

  StreamController<File> _photoOneStreamController =
      new StreamController<File>.broadcast();

  StreamController<String> _stageStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _statusOkStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _statusNokStreamController =
      new StreamController<String>.broadcast();

  Function(String) get addComment => _commentsStreamController.sink.add;

  Stream<String> get getComment => _commentsStreamController.stream;

  Function(String) get addValidateUpdate =>
      _validateUpdateStreamController.sink.add;

  Stream<String> get getValidateUpdate =>
      _validateUpdateStreamController.stream;

  Function(File) get addPhotoOne => _photoOneStreamController.sink.add;

  Stream<File> get getPhotoOne => _photoOneStreamController.stream;

  Function(String) get addStage => _stageStreamController.sink.add;

  Stream<String> get getStage => _stageStreamController.stream;

  Function(String) get addStatusOk => _statusOkStreamController.sink.add;

  Stream<String> get getStatusOk => _statusOkStreamController.stream;

  Function(String) get addStatusNok => _statusNokStreamController.sink.add;

  Stream<String> get getStatusNok => _statusNokStreamController.stream;

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _commentsStreamController?.close();
    _validateUpdateStreamController?.close();
    _photoOneStreamController?.close();
    _stageStreamController?.close();
    _statusOkStreamController?.close();
    _statusNokStreamController?.close();
    _isShowLoading?.close();
    createTrackPost?.close();
    uploadPhotoPost?.close();
    getTracks?.close();
  }

  void getTeamTrack({String teamId}) async {
    try {
      _isShowLoading.add(true);
      var response = await repo
          .getTeamTrack(TeamModel(teamId: storageService.getTeamId()).toJson());

      if (response.length > 0) {
        _isShowLoading.add(false);
        getTracksIn.add(response);
      } else {
        _isShowLoading.add(false);
        getTracks.addError(204);
      }
    } catch (e) {
      _isShowLoading.add(false);
      getTracks.addError(404);
    }
  }

  void uploadPhotoToS3() async {
    _isShowLoading.add(true);
    arrayPhotos.forEach((_image) {
      String nameFile =
          '${md5.convert(utf8.encode(_image.path))}${extension(_image.path)}';
      try {
        _uploadToS3
            .send(
          imagePathInS3Bucket: 'images/$nameFile',
          imagePathOfPhone: _image.path,
          nameFile: nameFile,
          onSendProgress: (double val) => {},
        )
            .then((link) {
          arrayPhotosLinkUploaded.add(link);
          if (arrayPhotosLinkUploaded.length == arrayPhotos.length) {
            return createTrack();
          }
          // arrayPhotos.add(link);
        }).catchError((r) {
          _isShowLoading.add(false);
          createTrackPost.addError(404);
        });
      } catch (e) {
        _isShowLoading.add(false);
        createTrackPost.addError(404);
      }
    });
  }

  void createTrack() async {
    try {
      var response = await repo.createTrack(TeamModel(
        teamId: storageService.getTeamId(),
        stage: trackStage,
        status: trackStatus,
        comment: trackComment,
        files: arrayPhotosLinkUploaded,
      ).toJson());
      if (response.id != null) {
        storageService.setTrackId(response.id);
        _isShowLoading.add(false);
        createTrackPostIn.add(response);
      } else {
        _isShowLoading.add(false);
        createTrackPost.addError(response);
      }
    } catch (e) {
      _isShowLoading.add(false);
      createTrackPost.addError(e);
    }
  }

  updateComment(String text) {
    addComment(
      text.isEmpty ? null : text.trim().length > 0 ? text : null,
    );
  }

  updateStage(String text) {
    addStage(text.isEmpty ? "Ideation" : text);
  }

  handleStatus(String buttonOk, String buttonNok) {
    if (buttonOk == "nok") {
      addStatusOk("");
      addStatusNok("nok");
    } else if (buttonNok == "ok") {
      addStatusOk("ok");
      addStatusNok("");
    } else {
      addStatusOk(buttonOk);
      addStatusNok(buttonNok);
    }
  }

  validateUpdateButton(String stage, String status, String comments) {
    final bool stageIsValid =
        stage.isEmpty ? false : stage.trim().length > 0 ? true : false;
    final bool statusIsValid =
        status.isEmpty ? false : status.trim().length > 0 ? true : false;
    final bool commentsIsValid = comments == null || comments.isEmpty
        ? false
        : comments.trim().length > 0 ? true : false;

    addValidateUpdate(
        stageIsValid && statusIsValid && commentsIsValid ? "ok" : "nok");
  }
}
