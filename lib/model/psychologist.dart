class Psychologist {
  final String firstname;
  final String lastname;
  final String detail;
  final String gender;
  final int age;
  final String phone;
  final String hospital;
  final String ratePerHours;
  final String imagePath;

  Psychologist({
    required this.firstname,
    required this.lastname,
    required this.detail,
    required this.gender,
    required this.age,
    required this.phone,
    required this.hospital,
    required this.ratePerHours,
    required this.imagePath,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'detail': detail,
      'gender': gender,
      'age': age,
      'phone': phone,
      'hospital': hospital,
      'rate_per_hours': ratePerHours,
      'image_path': imagePath,
    };
  }

  factory Psychologist.fromMap(Map<String, dynamic> map) {
    return Psychologist(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      detail: map['detail'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? 0,
      phone: map['phone'] ?? '',
      hospital: map['hospital'] ?? '',
      ratePerHours: map['rate_per_hours'] ?? '',
      imagePath: map['image_path'] ?? '',
    );
  }
}
