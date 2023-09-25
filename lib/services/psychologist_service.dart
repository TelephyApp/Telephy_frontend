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

  Future<Psychologist?> getPsyByUID(String uid) async {
    try {
      final DocumentSnapshot psyDoc = await psychologists.doc(uid).get();

      if (psyDoc.exists) {
        final userData = psyDoc.data() as Map<String, dynamic>;
        return Psychologist.fromMap(userData);
      } else {
        return null; // User not found
      }
    } catch (e) {
      print('Error fetching user: $e');
      throw e;
    }
  }


}
