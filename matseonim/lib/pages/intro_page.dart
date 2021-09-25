import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:matseonim/pages/login_page.dart';
import 'package:matseonim/pages/main_page.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return MainPage();
          } else {
            return LoginPage();
          }
        });
  }
}
