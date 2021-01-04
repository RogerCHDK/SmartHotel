import 'package:firebase_auth/firebase_auth.dart';

class _MenuProvider {
  FirebaseUser user;
  _MenuPovider() {
    //cargarDatos();
  }

  Future<FirebaseUser> cargardatos() async {
    user = await FirebaseAuth.instance.currentUser();
    print("Hola" + user.uid);
    return user;
  }
}

final menuProvider = new _MenuProvider();
