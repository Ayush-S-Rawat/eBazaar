import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebazaar/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Storing Data
  storeUserData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set(
        {'name': name, 'password': password, 'email': email, 'imageUrl': ''});
  }

  // signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
