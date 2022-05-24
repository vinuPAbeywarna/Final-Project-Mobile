class RegiUserModel {
  final String name;
  final String email;
  final String password;
  final String conpassword;
  final String contctno;
  final String nic;
  final String city;
  final String birthday;
  final String gender;
  final String address;
  final String role;

  RegiUserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.conpassword,
      required this.contctno,
      required this.address,
      this.city = " ",
      this.gender = " ",
      required this.birthday,
      required this.nic,
      required this.role});

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "email": this.email,
        "password": this.password,
        "password_confirmation": this.conpassword,
        "nic": this.nic,
        "contact_no": this.contctno,
        "address": this.address,
        "city": this.city,
        "birthday": this.birthday,
        "gender": this.gender,
        "role": this.role
      };

  RegiUserModel.fromMap(Map<dynamic, dynamic> map)
      : name = map["name"],
        email = map["email"] as String,
        password = map["password"] ?? " ",
        conpassword = map["password_confirmation"] ?? " ",
        role = map["role"],
        contctno = map["contact_no"],
        nic = map["nic"] as String,
        city = map["city"] ?? " ",
        address = map["address"],
        birthday = map["birthday"] ?? " ",
        gender = map["gender"] ?? " ";
}
