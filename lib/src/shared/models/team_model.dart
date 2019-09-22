class TeamModel {
  String stage;
  List<String> users;
  List<String> tracks;
  String sId;
  String name;
  String hackathon;
  String createdAt;
  String updatedAt;
  int v;
  String hackaId;

  TeamModel({
    this.stage,
    this.users,
    this.tracks,
    this.sId,
    this.name,
    this.hackathon,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.hackaId,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    users = json['users'].cast<String>();
    tracks = json['tracks'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    hackathon = json['hackathon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hackaId'] = this.hackaId;
    // data['stage'] = this.stage;
    // data['users'] = this.users;
    // data['tracks'] = this.tracks;
    // data['_id'] = this.sId;
    // data['name'] = this.name;
    // data['hackathon'] = this.hackathon;
    // data['createdAt'] = this.createdAt;
    // data['updatedAt'] = this.updatedAt;
    // data['__v'] = this.v;
    return data;
  }
}
