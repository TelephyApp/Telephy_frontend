import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telephy/model/psychologist.dart';
import 'package:telephy/services/psychologist_service.dart';

class GoogleAuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? _googleSignInAccount =
          await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await _googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential authResult =
            await _auth.signInWithCredential(authCredential);
        final User? user = authResult.user;

        if (user != null) {
          if(user.email!.endsWith("@kmitl.ac.th")){
            Psychologist psychologist = Psychologist(firstname: "None", lastname: "None", detail: "None", gender: "None", age: 0, phone: "None", hospital: "None", ratePerHours: "ratePerHours");
            PsychologistService().storePsychData(user, psychologist);
          }
          return user;
        } else {
          await _auth.signOut();
          await _googleSignIn.signOut();
          return null;
        }
      }
    } on FirebaseException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
