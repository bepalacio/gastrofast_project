import 'package:f_202110_firebase_google_login/Formularios/RegisterForm.dart';
import 'package:f_202110_firebase_google_login/Formularios/home.dart';
import 'package:f_202110_firebase_google_login/Formularios/registerPage.dart';
import 'package:f_202110_firebase_google_login/google/google_central.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'emailPage.dart';

class LoginPage extends StatefulWidget {
  final String titulo;
  LoginPage({Key key, this.titulo}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  _login(correo, pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: correo, password: pass)
          .then((UserCredential currentUser) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (context) => EmailPage(),
        ));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found");
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration:
                  InputDecoration(labelText: "Correo", icon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(
                  labelText: "Contraseña", icon: Icon(Icons.vpn_key)),
            ),
            SizedBox(
              height: 15.0,
            ),
            FlatButton(
              child: Text("Login"),
              color: Colors.orangeAccent,
              textColor: Colors.white,
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passController.text)
                    .then((UserCredential user) {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) => Home(),
                  ));
                }).catchError((e) {
                  print(e);
                });
                //_login(_emailController.text, _passController.text);
              },
            ),
            FlatButton(
              child: Text('Registrarse'),
              color: Colors.orangeAccent,
              textColor: Colors.white,
              onPressed: () => _pushPage(context, RegisterForm()),
            ),
            SignInButton(
              Buttons.Google,
              text: "Registrarse con google",
              onPressed: () => _pushPage(context, GoogleCentral()),
            ),
          ],
        ),
      ),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
