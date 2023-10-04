import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/model/users.dart';
import 'package:telephy/services/user_service.dart';

class PsychologistService {
  final CollectionReference psychologists =
      FirebaseFirestore.instance.collection('psychologists');
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

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

  Future<List<Psychologist>> getAllPsychologists() async {
    final querySnapshot = await psychologists.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Psychologist(
          firstname: doc['firstname'],
          lastname: doc['lastname'],
          detail: doc['detail'],
          gender: doc['gender'],
          age: doc['age'],
          phone: doc['phone'],
          hospital: doc['hospital'],
          ratePerHours: doc['rate_per_hours'],
          imagePath: doc['image_path']);
    }).toList();
  }

  Future<Psychologist?> getPsychologistByUID(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = (await psychologists
          .doc(uid)
          .get()) as DocumentSnapshot<Map<String, dynamic>>;

      if (doc.exists) {
        final Map<String, dynamic> data = doc.data()!;
        return Psychologist.fromMap(data);
      } else {
        return null;
      }
    } catch (error) {
      print('Error getting psychologist by UID: $error');
      return null;
    }
  }

  Future<Psychologist?> getPsychologistByFullName(
      String firstName, String lastName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('psychologists')
              .where('firstname', isEqualTo: firstName)
              .where('lastname', isEqualTo: lastName)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        final Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        return Psychologist.fromMap(data);
      } else {
        // No matching doctor found
        return null;
      }
    } catch (error) {
      print('Error getting psychologist: $error');
      return null;
    }
  }

  Future<String?> getPsychologistUidByObject(Psychologist psychologist) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('psychologists')
              .where('firstname', isEqualTo: psychologist.firstname)
              .where('lastname', isEqualTo: psychologist.lastname)
              .limit(1) // Limit the query to 1 result (assuming unique names)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Return the UID of the first matching psychologist
        return querySnapshot.docs.first.id;
      } else {
        // No matching psychologist found
        return null;
      }
    } catch (error) {
      print('Error getting psychologist UID by object: $error');
      return null;
    }
  }

  Future<bool> checkEmailExist() async {
    String provider = await UserService().getLoggedInProvider();
    String? email;
    if (provider == "Google") {
      email = await UserService().getGoogleSignInEmail();
    } else {
      email = FirebaseAuth.instance.currentUser?.email;
    }
    return await UserService().doesEmailExist(email!);
  }

  Future<bool> doesPsychologistExistByUid(String uid) async {
    try {
      final DocumentSnapshot doc = await psychologists.doc(uid).get();
      return doc.exists;
    } catch (error) {
      print('Error checking psychologist existence by UID: $error');
      return false;
    }
  }

  Future<bool> isPsychologist(String uid) async {
    final psyQuery = await psychologists.doc(uid).get();
    final userQuery = await users.doc(uid).get();

    return psyQuery.exists && !userQuery.exists;
  }
}
