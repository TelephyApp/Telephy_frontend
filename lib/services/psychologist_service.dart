import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/users.dart';

class PsychologistService {
  final CollectionReference psychologists =
      FirebaseFirestore.instance.collection('psychologists');

  Future<void> storePsychData(User user, Psychologist psych) async {
    await psychologists.doc(user.uid).set({
      'firstname': psych.firstname,
      'lastname': psych.lastname,
      'detail': psych.detail,
      'gender': psych.gender,
      'age': psych.age,
      'phone': psych.phone,
      'hospital': psych.hospital,
      'rate_per_hours': psych.ratePerHours,
      'image_path': psych.imagePath,
    });
  }


}
