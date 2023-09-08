// {
//     "user": {
//         "id": 10,
//         "name": "user3",
//         "email": "user3@gmail.com",
//         "membership_number": null,
//         "address": null,
//         "gender": null,
//         "dob": null,
//         "phone_no": null,
//         "alt_phone_no": null,
//         "email_verified_at": null,
//         "account_type_id": 6,
//         "user_type": "Member",
//         "status": "Inactive",
//         "comment": null,
//         "subscribed": 0,
//         "default_pipeline": null,
//         "points": "0",
//         "created_at": "2023-08-31T02:33:14.000000Z",
//         "updated_at": "2023-08-31T02:33:14.000000Z",
//         "active_status": 0,
//         "avatar": "avatar.png",
//         "dark_mode": 0,
//         "messenger_color": null,
//         "nok_name": null,
//         "nok_address": null,
//         "nok_phone_no": null
//     },
//     "authorization": {
//         "token": "260|ryI4p18FG2MVbeEt4LT5KS5l2M7Xq8317F9DPwe2",
//         "type": "bearer"
//     }
// }
class UserData {
  final int id;
  final String name;
  final String email;
  final String token;
  
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });
}