class JoinModel {
  String id;
  String name;
  String identifier;
  bool isMentor;
  String status;
  String code;
  String mentorLink;
  String participantLink;

  JoinModel({
    this.id,
    this.name,
    this.identifier,
    this.isMentor,
    this.status,
    this.code,
    this.mentorLink,
    this.participantLink,
  });

  JoinModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    identifier = json['identifier'];
    isMentor = json['isMentor'];
    status = json['status'];
    mentorLink = json['mentorLink'];
    participantLink = json['participantLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}
