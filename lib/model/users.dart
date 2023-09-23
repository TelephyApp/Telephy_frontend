class Users {
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String gender;
  final int age;
  final DateTime birthday;
  final String phone;
  final String medicalCondition;
  final String imagePath;

  Users({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.gender,
    required this.age,
    required this.phone,
    required this.birthday,
    required this.medicalCondition,
    required this.imagePath,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'gender': gender,
      'age': age,
      'phone': phone,
      'email': email,
      'birthday': birthday,
      'medical_condition': medicalCondition,
      'image_path': imagePath,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      username: map['username'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? 0,
      phone: map['phone'] ?? '',
      birthday: map['birthday'] ?? DateTime.now(),
      medicalCondition: map['medical_condition'] ?? '',
      imagePath: map['image_path'] ?? '',
    );
  }
}
