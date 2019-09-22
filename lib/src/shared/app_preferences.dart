import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService {
  static AppPreferencesService _instance;

  static const String PREFERENCES_USER_LOGGED_KEY = "PREFERENCES_USER_LOGGED";
  static const String PREFERENCES_CREATE_HACKATHON_SUCCESS_KEY =
      "PREFERENCES_CREATE_HACKATHON_SUCCESS_KEY";
  static const String PREFERENCES_HACKATHON_ID_KEY =
      "PREFERENCES_HACKATHON_ID_KEY";
  static const String PREFERENCES_HACKATHON_IDENTIFIER_KEY =
      "PREFERENCES_HACKATHON_IDENTIFIER_KEY";
  static const String PREFERENCES_HACKATHON_NAME_KEY =
      "PREFERENCES_HACKATHON_NAME_KEY";
  static const String PREFERENCES_MENTOR_CODE_KEY =
      "PREFERENCES_MENTOR_CODE_KEY";
  static const String PREFERENCES_IS_MENTOR_KEY = "PREFERENCES_IS_MENTOR_KEY";
  static const String PREFERENCES_PARTICIPANT_CODE_KEY =
      "PREFERENCES_PARTICIPANT_CODE_KEY";
  static const String PREFERENCES_TEAM_ID_KEY = "PREFERENCES_TEAM_ID_KEY";
  static const String PREFERENCES_TEAM_STAGE_KEY = "PREFERENCES_TEAM_STAGE_KEY";
  static const String PREFERENCES_USER_ID_KEY = "PREFERENCES_USER_ID_KEY";
  static const String PREFERENCES_TRACK_ID_KEY = "PREFERENCES_TRACK_ID_KEY";
  static const String PREFERENCES_ACCESS_BY_CODE_KEY =
      "PREFERENCES_USER_ID_KEY";

  // Create storage secure
  static SharedPreferences _preferences;

  AppPreferencesService() {
    _instance = this;
  }

  static Future<AppPreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = AppPreferencesService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  bool isUserLogged() {
    return _preferences.getBool(PREFERENCES_USER_LOGGED_KEY) ?? false;
  }

  setIsUserLogged(bool value) async {
    return _preferences.setBool(PREFERENCES_USER_LOGGED_KEY, value);
  }

  bool isCreateHackathonSuccess() {
    return _preferences.getBool(PREFERENCES_CREATE_HACKATHON_SUCCESS_KEY) ??
        false;
  }

  setCreateHackathonSuccess(bool value) async {
    return _preferences.setBool(
        PREFERENCES_CREATE_HACKATHON_SUCCESS_KEY, value);
  }

  setHackathonId(String hackathonId) {
    return _preferences.setString(PREFERENCES_HACKATHON_ID_KEY, hackathonId);
  }

  String getHackathonId() {
    return _preferences.getString(PREFERENCES_HACKATHON_ID_KEY) ?? "";
  }

  setHackathonIdentifier(String identifier) {
    return _preferences.setString(
        PREFERENCES_HACKATHON_IDENTIFIER_KEY, identifier);
  }

  String getHackathonIdentifier() {
    return _preferences.get(PREFERENCES_HACKATHON_IDENTIFIER_KEY) ?? "";
  }

  setHackathonName(String hackathonName) {
    return _preferences.setString(
        PREFERENCES_HACKATHON_NAME_KEY, hackathonName);
  }

  String getHackathonName() {
    return _preferences.get(PREFERENCES_HACKATHON_NAME_KEY) ?? "";
  }

  bool isMentor() {
    return _preferences.getBool(PREFERENCES_IS_MENTOR_KEY) ?? false;
  }

  setIsMentor(bool value) async {
    return _preferences.setBool(PREFERENCES_IS_MENTOR_KEY, value);
  }

  setMentorCode(String mentorCode) {
    return _preferences.setString(PREFERENCES_MENTOR_CODE_KEY, mentorCode);
  }

  String getMentorCode() {
    return _preferences.getString(PREFERENCES_MENTOR_CODE_KEY) ?? "";
  }

  setParticipantCode(String participantCode) {
    return _preferences.setString(
        PREFERENCES_PARTICIPANT_CODE_KEY, participantCode);
  }

  String getParticipantCode() {
    return _preferences.getString(PREFERENCES_PARTICIPANT_CODE_KEY) ?? "";
  }

  setTeamId(String teamId) {
    return _preferences.setString(PREFERENCES_TEAM_ID_KEY, teamId);
  }

  String getTeamId() {
    return _preferences.getString(PREFERENCES_TEAM_ID_KEY) ?? "";
  }

  setTeamStage(String teamStage) {
    return _preferences.setString(PREFERENCES_TEAM_STAGE_KEY, teamStage);
  }

  String getTeamStage() {
    return _preferences.getString(PREFERENCES_TEAM_STAGE_KEY) ?? "";
  }

  setTrackId(String trackid) {
    return _preferences.setString(PREFERENCES_TRACK_ID_KEY, trackid);
  }

  String getTrackId() {
    return _preferences.getString(PREFERENCES_TRACK_ID_KEY) ?? "";
  }

  setUserId(String userId) {
    return _preferences.setString(PREFERENCES_USER_ID_KEY, userId);
  }

  String getUserId() {
    return _preferences.getString(PREFERENCES_USER_ID_KEY) ?? "";
  }

  bool isAccessByCode() {
    return _preferences.getBool(PREFERENCES_ACCESS_BY_CODE_KEY) ?? false;
  }

  setIsAccessByCode(bool value) async {
    return _preferences.setBool(PREFERENCES_ACCESS_BY_CODE_KEY, value);
  }

  void clear() {
    _preferences.clear();
  }
}
