// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:uuid/uuid.dart';
// import 'package:weather_app/models/account.dart';
// import 'package:weather_app/utils/ui_utils.dart';
//
// import 'firebase_repository.dart';
//
// class FirebaseServices {
//   final FirebaseRepository firebaseRepository = FirebaseRepository();
//
//   Future createAccountWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String firstName,
//     required String lastName,
//     required File? avatar,
//     Function(MyAccount)? onDone,
//     Function? onError,
//   }) async {
//     try {
//       await firebaseRepository.firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) async {
//         if (value.user != null) {
//           String? photoUrl;
//           if (avatar != null) {
//             photoUrl = await uploadFile(value.user!.uid, avatar);
//           }
//           final appUser = MyAccount(
//               uid: value.user!.uid,
//               firstName: firstName,
//               lastName: lastName,
//               email: value.user!.email,
//               photoUrl: photoUrl);
//           await createUserToDatabase(appUser).then((value) => onDone!(appUser));
//         }
//       });
//       UIUtils.showToast('SUCCESS_REGISTER');
//     } on FirebaseAuthException catch (e) {
//       onError!();
//       if (e.code == 'weak-password') {
//         UIUtils.showToast("The password provided is too weak.");
//       } else if (e.code == 'email-already-in-use') {
//         UIUtils.showToast("The account already exists for that email.");
//       } else {
//         UIUtils.showToast(e.message ?? "");
//       }
//     }
//   }
//
//   Future signInWithEmailAndPassword(
//       {required String email, required String password}) async {
//     try {
//       await firebaseRepository.firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);
//       UIUtils.showToast("Logged in successfully");
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         UIUtils.showToast("No user found for that email.");
//       } else if (e.code == 'wrong-password') {
//         UIUtils.showToast("Wrong password provided for that user.");
//       } else {
//         UIUtils.showToast(e.message ?? "");
//       }
//     }
//   }
//
//   // Future signInWithGoogle() async {
//   //   UserCredential? user;
//   //   try {
//   //     GoogleSignInAccount? signInAccount =
//   //         await firebaseRepository.googleSignIn.signIn();
//   //     if (signInAccount != null) {
//   //       GoogleSignInAuthentication signInAuthentication =
//   //           await signInAccount.authentication;
//   //       final AuthCredential credential = GoogleAuthProvider.credential(
//   //           accessToken: signInAuthentication.accessToken,
//   //           idToken: signInAuthentication.idToken);
//   //       user = await firebaseRepository.firebaseAuth
//   //           .signInWithCredential(credential);
//   //       if (user.user != null) {
//   //         final appUser = Account(
//   //             uid: user.user!.uid,
//   //             firstName: user.user!. ?? "",
//   //             lastName: user.user!.lastName ?? "",
//   //             email: user.user!.email,
//   //             photoUrl: user.user!.photoURL);
//   //         await createUserToDatabase(appUser);
//   //       }
//   //     }
//   //   } on FirebaseAuthException catch (e) {
//   //     UIUtils.showToast(e.message ?? "");
//   //   }
//   // }
//
//   Future signOut() async {
//     firebaseRepository.googleSignIn.signOut();
//     return firebaseRepository.firebaseAuth.signOut();
//   }
//
//   Future<MyAccount?> getUser(String uid) async {
//     final snapshot =
//         await firebaseRepository.firestore.collection("users").doc(uid).get();
//     if (snapshot.exists) {
//       return MyAccount.fromJson(snapshot.data()!);
//     }
//     return null;
//   }
//
//   Stream<User?> userChangeStream() async* {
//     yield* firebaseRepository.firebaseAuth.userChanges();
//   }
//
//   Future createUserToDatabase(MyAccount appUser) async {
//     await firebaseRepository.firestore
//         .collection("users")
//         .doc(appUser.uid)
//         .set(appUser.toJson());
//   }
//
//   Future<String?> uploadFile(String userId, File file) async {
//     String fileName = const Uuid().v4();
//     try {
//       final uploaTask = await firebaseRepository.firebaseStorage
//           .ref('users/$userId/$fileName.jpg')
//           .putFile(file);
//       return uploaTask.ref.getDownloadURL();
//     } on FirebaseException catch (e) {
//       UIUtils.showToast(e.message ?? "");
//     }
//     return null;
//   }
// }
