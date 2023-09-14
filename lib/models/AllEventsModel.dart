
class AllEventsModel {
  String id;
  String name;
  String start_date;
  String end_date;
  String rate;
  String member_rate;
  String points;
  String attachment_name;
  String banner_name;
  String details;
  bool attandence_request;

  AllEventsModel({
    required this.id,
    required this.name,
    required this.attandence_request,
    required this.start_date,
    required this.end_date,
    required this.rate,
    required this.member_rate,
    required this.points,
    required this.attachment_name,
    required this.banner_name,
    required this.details,
  });
  
}
