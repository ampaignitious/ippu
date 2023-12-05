class UserData {
  final int id;
   String name;
  final String email;
  final String token;
  final String? gender;
  late final String? dob;
  final String? membership_number;
  final String? address;
  final String? phone_no;
  final String? points;
  final String? alt_phone_no;
  final String? nok_name;
  final String? nok_address;
  final String? nok_phone_no;
  final String? subscription_status;
  String profile_pic;
 
  UserData({
    required this.id,
    this.points,
    required this.name,
    required this.email,
    required this.token,
    this.gender,
    this.dob,
    this.subscription_status,
    this.membership_number,
    this.address,
    this.phone_no,
    this.alt_phone_no,
    this.nok_name,
    this.nok_address,
    this.nok_phone_no,
    required this.profile_pic
  });
}
