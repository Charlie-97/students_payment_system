import 'package:students_payment_system/services/auth/auth_exceptions.dart';
import 'package:students_payment_system/services/auth/auth_provider.dart'
    as my_auth_provider;
import 'package:students_payment_system/services/auth/auth_user.dart';

//Use this class to create the auth functions from the API provided by the BE

class AppAuthProvider implements my_auth_provider.AuthProvider {
  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    try {
      // await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password);

      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    }
    // on Exception catch (e) {
    //   if (e.code == 'email-already-in-use') {
    //     throw EmailAlreadyInUseAuthException();
    //   } else if (e.code == 'weak-password') {
    //     throw WeakPasswordAuthException();
    //   } else {
    //     throw GenericAuthException();
    //   }
    // }
    catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    return null;

    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   return AuthUser.fromFirebase(user);
    // } else {
    //   return null;
    // }
  }

  @override
  Future<AuthUser> login(
      {required String email, required String password}) async {
    try {
      // await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    }
    // on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     throw UserNotFoundAuthException();
    //   } else if (e.code == 'wrong-password') {
    //     throw WrongPasswordAuthException();
    //   } else {
    //     throw GenericAuthException();
    //   }
    // }
    catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async {
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   await FirebaseAuth.instance.signOut();
    // } else {
    //   throw UserNotLoggedInAuthException();
    // }
  }

  @override
  Future<void> sendEmailVerification() async {
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   await user.sendEmailVerification();
    // } else {
    //   throw UserNotLoggedInAuthException();
    // }
  }

  @override
  Future<void> initialize() async {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Future<void> updateDisplayName({required String displayName}) async {
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   await user.updateDisplayName(displayName);
    // } else {
    //   throw UserNotFoundAuthException();
    // }
  }

  @override
  Future<void> resetPassword(String email) {
    try {
      return Future.value();
      // return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
    // on FirebaseAuthException catch (e) {
    //   switch (e.code) {
    //     case 'firebase_auth/invalid-email':
    //       throw InvalidEmailAuthException();
    //     case 'firebase_auth/user-not-found':
    //       throw UserNotFoundAuthException();
    //     default:
    //       throw GenericAuthException();
    //   }
    // }

    catch (_) {
      throw GenericAuthException();
    }
  }
}
