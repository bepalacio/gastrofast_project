import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterForm extends StatefulWidget {
  final String titulo = "Registrarse";

  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool success;
  String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                  labelText: "Nombre",
                  icon: Icon(Icons.supervised_user_circle_outlined)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
              },
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: InputDecoration(
                  labelText: "Apellido",
                  icon: Icon(Icons.supervised_user_circle_outlined)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
              },
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: "Nombre de usuario",
                  icon: Icon(Icons.supervised_user_circle)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration:
                  InputDecoration(labelText: "Correo", icon: Icon(Icons.email)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
              },
            ),
            TextFormField(
              controller: _passController,
              decoration: InputDecoration(
                  labelText: "Contraseña", icon: Icon(Icons.vpn_key)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese una contraseña';
                }
              },
            ),
            Container(
              alignment: Alignment.center,
              child: FlatButton(
                  child: Text('Registrarse'),
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    _register();
                    //dispose();
                  }),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(success == null
                  ? ''
                  : (success
                      ? userEmail + ' se ha rgistrado con exito'
                      : 'No se podido registrar el usuario')),
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _usernameController.dispose();
    _passController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _register() async {
    final UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passController.text);

    if (user.user != null) {
      setState(() {
        success = true;
        userEmail = user.user.email;
      });
    } else {
      success = false;
    }
  }
}
