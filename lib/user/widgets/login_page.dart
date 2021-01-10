import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hoteles/user/widgets/button_green.dart';
import 'package:hoteles/user/widgets/gradient_back.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  Firestore firestore = Firestore.instance;

  final formKey = new GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  String _tipo;
  String _nombre;
  String _apellido_p;
  String _apellido_m;
  FormType _formType = FormType.login;
  double screenWidht;

  CollectionReference users = Firestore.instance.collection('usuarios');

  Future<void> addUser(String id) {
    //  // Call the user's CollectionReference to add a new user
    return users
        .document(id)
        .setData({
          'correo': _email,
          'contrasenia': _password,
          'tipo': _tipo,
          'nombre': _nombre,
          'apellido_p': _apellido_p,
          'apellido_m': _apellido_m,
        })
        .then((value) => print("Usuario actualizado"))
        .catchError((error) => print("Error al insertar usuario: $error"));
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      print('Logeado. Email: $_email, Password: $_password');

      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          try {
            final user = await _auth.signInWithEmailAndPassword(
                email: _email, password: _password);
            print("Logeado: ${user.user.uid}");
            tipoUsuario(user.user.uid);
            formKey.currentState.reset();
          } catch (e) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Correo/Contraseña no valido"),
                );
              },
            );
          }
        } else {
          try {
            if (_tipo == "Administrador" || _tipo == "Consultor") {
              final user = await _auth.createUserWithEmailAndPassword(
                  email: _email, password: _password);
              addUser(user.user.uid);
              print('Usuario regitrado: ${user.user.uid} ');
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Registro exitoso"),
                  );
                },
              );
              formKey.currentState.reset();
            } else
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Seleccione Admin/Consultor"),
                  );
                },
              );
          } catch (e) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Datos no validos"),
                );
              },
            );
          }
        }
      } catch (e) {
        print("error" + e);
      }
    }
  }

  String _isAdmin;
  void tipoUsuario(String id) {
    Firestore.instance
        .collection('usuarios')
        .document(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data}');
        _isAdmin = documentSnapshot['tipo'];
        if (_isAdmin.compareTo("Administrador") == 0) {
          print("Es admin");
          Navigator.of(context).pushNamed('/principal');
        } else {
          print("Es consultor");
          Navigator.of(context).pushNamed('/user');
        }
      }
    });
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(
              height:
                  null), //al pasarle el heigth como null se pone en automatico en fullscreen
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                //Esto no permitira que haya desbordmiento de texto
                child: Container(
                  width:
                      screenWidht, //Aqui es donde se evita el desbordamiento haciendo que se ajuste a la pantalla
                  child: Text(
                    "Bienvenido a \n SmarHotel",
                    style: TextStyle(
                        fontSize: 37.0,
                        fontFamily: "Lato",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: new Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buildSubmitButtons(),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) => value.isEmpty ? 'Campo vacío' : null,
          onSaved: (value) => _email = value,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Constraseña",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          obscureText: true,
          validator: (value) => value.isEmpty ? 'Campo vacío' : null,
          onSaved: (value) => _password = value,
        ),
        InkWell(
          onTap:
              validateAndSubmit, //poniendo widget. podemos acceder a las propiedades de la otra clase
          child: Container(
            margin: EdgeInsets.only(
              top: 30.0,
              left: 20.0,
              right: 20.0,
            ),
            height: 50.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFa7ff84), //color de arriba
                  Color(0xFF1cbb78) //color de abajo
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
              ),
            ),
          ),
        ),
        FlatButton(
            onPressed: moveToRegister,
            child: Text(
              "¿No tienes cuenta? Registrate",
              style: TextStyle(
                  fontSize: 15.0,
                  decoration: TextDecoration.underline,
                  color: Colors.white),
            ))
      ];
    } else {
      return [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Nombre",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) => value.isEmpty ? 'Campo vacío' : null,
          onSaved: (value) => _nombre = value,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Apellido Paterno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) => value.isEmpty ? 'Campo vacío' : null,
          onSaved: (value) => _apellido_p = value,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Apellido Materno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) => value.isEmpty ? 'Campo vacío' : null,
          onSaved: (value) => _apellido_m = value,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) => value.isEmpty ? 'Campo vacío' : null,
          onSaved: (value) => _email = value,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Constraseña",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            fillColor: Colors.white,
            filled: true,
          ),
          obscureText: true,
          validator: (value) => value.isEmpty ? 'Campo vacío' : null,
          onSaved: (value) => _password = value,
        ),
        RadioButtonGroup(
          labels: [
            "Administrador",
            "Consultor",
          ],
          orientation: GroupedButtonsOrientation.HORIZONTAL,
          activeColor: Colors.white,
          margin: EdgeInsets.only(left: 50.0),
          labelStyle: TextStyle(color: Colors.white),
          onChange: (String label, int index) =>
              print("label: $label index: $index"),
          onSelected: (String label) {
            _tipo = label;
          },
          itemBuilder: (Radio rb, Text txt, int i) {
            return Row(
              children: <Widget>[
                rb,
                txt,
              ],
            );
          },
        ),
        InkWell(
          onTap:
              validateAndSubmit, //poniendo widget. podemos acceder a las propiedades de la otra clase
          child: Container(
            margin: EdgeInsets.only(
              top: 10.0,
              left: 20.0,
              right: 20.0,
            ),
            height: 50.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFa7ff84), //color de arriba
                  Color(0xFF1cbb78) //color de abajo
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Center(
              child: Text(
                "Crear cuenta",
                style: TextStyle(
                    fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
              ),
            ),
          ),
        ),
        FlatButton(
            onPressed: moveToLogin,
            child: Text(
              "¿Tienes cuenta? Logeate",
              style: TextStyle(
                  fontSize: 15.0,
                  decoration: TextDecoration.underline,
                  color: Colors.white),
            )),
      ];
    }
  }
}
