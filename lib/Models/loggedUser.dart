class LoggedUserModel {
  final int id;
  final String name;
  final String email;

  final String contctno;
  final String nic;
  final String city;
  final String birthday;
  final String gender;
  final String address;
  final String role;

  LoggedUserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.contctno,
      required this.address,
      this.city = " ",
      this.gender = " ",
      required this.birthday,
      required this.nic,
      required this.role});

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "name": this.name,
        "email": this.email,
        "nic": this.nic,
        "contact_no": this.contctno,
        "address": this.address,
        "city": this.city,
        "birthday": this.birthday,
        "gender": this.gender,
        "role": this.role
      };

  LoggedUserModel.fromMap(Map<dynamic, dynamic> map)
      : id = map["id"],
        name = map["name"],
        email = map["email"] as String,
        role = map["role"],
        contctno = map["contact_no"],
        nic = map["nic"] as String,
        city = map["city"] ?? " ",
        address = map["address"],
        birthday = map["birthday"] ?? " ",
        gender = map["gender"] ?? " ";
}
