import 'dart:io';

class TeamModel {
  String stage;
  List<String> users;
  List<String> tracks;
  String id;
  String name;
  String hackathon;
  String createdAt;
  String updatedAt;
  int v;
  String hackaId;
  String userId;
  String teamId;
  String msg;
  String team;
  List<String> files;
  String comment;
  String status;
  File file;
  String trackId;
  int size;
  String url;
  String track;
  String key;

  TeamModel({
    this.stage,
    this.users,
    this.tracks,
    this.id,
    this.name,
    this.hackathon,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.hackaId,
    this.userId,
    this.teamId,
    this.msg,
    this.team,
    this.files,
    this.comment,
    this.status,
    this.file,
    this.trackId,
    this.size,
    this.url,
    this.track,
    this.key,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    users = json['users'] == null
        ? []
        : json['users'].length > 0 ? json['users'].cast<String>() : [];
    tracks = json['tracks'] == null
        ? []
        : json['tracks'].length > 0 ? json['tracks'].cast<String>() : [];
    id = json['_id'];
    name = json['name'];
    hackathon = json['hackathon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    msg = json['msg'];
    team = json['team'];
    files = json['files'] == null
        ? []
        : json['files'].length > 0 ? json['files'].cast<String>() : [];
    comment = json['comment'];
    status = json['status'];
    size = json['size'];
    url = json['url'];
    track = json['track'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hackaId'] = this.hackaId;
    data['userId'] = this.userId;
    data['teamId'] = this.teamId;
    data['hackaId'] = this.hackaId;
    data['name'] = this.name;
    data['stage'] = this.stage;
    data['status'] = this.status;
    data['comment'] = this.comment;
    data['file'] = this.file;
    data['trackId'] = this.trackId;
    data['files'] = this.files;
    return data;
  }
}
