
class CpdModel {
  final int id;
  final String code;
  final String topic;
  final String content;
  final String hours;
  final String points;
  final String targetGroup;
  final String location;
  final String startDate;
  final String endDate;
  final String normalRate;
  final String membersRate;
  final String resource;
  final String status;
  final String type;
  final String banner;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  CpdModel({
    required this.id,
    required this.code,
    required this.topic,
    required this.content,
    required this.hours,
    required this.points,
    required this.targetGroup,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.normalRate,
    required this.membersRate,
    required this.resource,
    required this.status,
    required this.type,
    required this.banner,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory CpdModel.fromJson(Map<String, dynamic> json) {
    return CpdModel(
      id: json['id'],
      code: json['code'],
      topic: json['topic'],
      content: json['content'],
      hours: json['hours'],
      points: json['points'],
      targetGroup: json['target_group'],
      location: json['location'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      normalRate: json['normal_rate'],
      membersRate: json['members_rate'],
      resource: json['resource'],
      status: json['status'],
      type: json['type'],
      banner: json['banner'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

}
