import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:telephy/model/users.dart';

class UserService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> storeUserData(User user, Users createdUser) async {
    await users.doc(user.uid).set({
      'firstname': createdUser.firstname,
      'lastname': createdUser.lastname,
      'username': createdUser.username,
      'gender': createdUser.gender,
      'age': createdUser.age,
      'phone': createdUser.phone,
      'email': createdUser.email,
      'birthday': createdUser.birthday,
      'medical_condition': createdUser.medicalCondition,
      'image_path': user.photoURL == "" ? "" : "./assets/images/user.png",
    });
  }

  Future<bool> doesEmailExist(String email) async {
    try {
      final QuerySnapshot result =
          await users.where('email', isEqualTo: email).get();
      return result.docs.isNotEmpty;
    } catch (error) {
      // Handle errors (e.g., Firestore query error)
      print('Error checking email existence: $error');
      return false;
    }
  }

  Future<Users?> getUserByUID(String uid) async {
    try {
      final DocumentSnapshot userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        return Users.fromMap(userData);
      } else {
        return null; // User not found
      }
    } catch (e) {
      print('Error fetching user: $e');
      throw e;
    }
  }

  Future<List<DocumentSnapshot>> getOnlineUsers() async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot onlineUsersSnapshot =
        await usersRef.where('online', isEqualTo: true).get();
    return onlineUsersSnapshot.docs;
  }

  Future<String> getGoogleSignInEmail() async {
    // Get the current user.
    final user = FirebaseAuth.instance.currentUser;

    // Get the provider data of the current user.
    final providerData = user!.providerData;

    // Find the provider data for the Google sign-in provider.
    final googleProviderData = providerData
        .firstWhere((provider) => provider.providerId == 'google.com');

    // Get the email from the provider data.
    final email = googleProviderData.email!;
    return email;
  }

  Future<String> getLoggedInProvider() async {
    // Get the current user.
    final user = FirebaseAuth.instance.currentUser!;

    // Get the provider data of the current user.
    final providerData = user.providerData;

    // Find the provider data for the Google sign-in provider or the email provider.
    final provider = providerData.firstWhere((provider) =>
        provider.providerId == 'google.com' ||
        provider.providerId == 'password');

    // Check the providerId property of the provider data to see if it is google.com or password.
    if (provider.providerId == 'google.com') {
      return 'Google';
    } else if (provider.providerId == 'password') {
      return 'Email';
    } else {
      return 'Unknown';
    }
  }
}
