class HackathonModel {
  String id;
  String name;
  String identifier;
  String mentorLink;
  String participantLink;
  String createdAt;
  String updatedAt;
  int v;

  HackathonModel(
      {this.id,
      this.name,
      this.identifier,
      this.mentorLink,
      this.participantLink,
      this.createdAt,
      this.updatedAt,
      this.v});

  HackathonModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    identifier = json['identifier'];
    mentorLink = json['mentorLink'];
    participantLink = json['participantLink'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['identifier'] = this.identifier;
    return data;
  }
}
