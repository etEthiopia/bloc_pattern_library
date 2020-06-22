import 'package:bloc_pattern_full/main.dart';

import '../exceptions/exceptions.dart';
import '../models/models.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    var logged = await storage.read(key: "loggedIn");
    if (logged != null) {
      if (logged == "yes") {
        String name = await storage.read(key: "name");
        String email = await storage.read(key: "email");
        return User(name: name, email: email);
      }
    }
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    //await Future.delayed(Duration(seconds: 1)); // simulate a network delay

    if (email.toLowerCase() != 'test@domain.com' || password != 'testpass123') {
      throw AuthenticationException(message: 'Wrong username or password');
    } else {
      await storage.write(key: "loggedIn", value: "yes");
      await storage.write(key: "name", value: "Test User");
      await storage.write(key: "email", value: "email");
      return User(name: 'Test User', email: email);
    }
  }

  @override
  Future<void> signOut() async {
    await storage.delete(key: "loggedIn");
    await storage.delete(key: "name");
    await storage.delete(key: "email");
    return null;
  }
}
