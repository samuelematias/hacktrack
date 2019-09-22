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

  TeamModel(
      {this.stage,
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
      this.teamId});

  TeamModel.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    users = json['users'].cast<String>();
    tracks = json['tracks'].cast<String>();
    id = json['_id'];
    name = json['name'];
    hackathon = json['hackathon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hackaId'] = this.hackaId;
    data['userId'] = this.userId;
    data['teamId'] = this.teamId;
    data['hackaId'] = this.hackaId;
    data['name'] = this.name;
    return data;
  }
}
