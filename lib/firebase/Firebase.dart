import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final storage = FirebaseStorage.instance;

final db = FirebaseFirestore.instance;

Future<String?> createUser(String email, String password) async {
  try{
    var res = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    // print(res.user?.email);
    return res.user?.email;
  }on FirebaseAuthException catch(e){
    print(e);
    return e.code;
  }catch(e){
    print(e);
  }
}

Future<String?> iniciarSesion(String email, String password) async {
  try{
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return credential.user?.email;
  }on FirebaseAuthException catch(e){
    print(e);
    return e.code;
  }
}

Future<bool> cerrarSesion() async {
  try{
    await FirebaseAuth.instance.signOut();
    return true;
  }on FirebaseAuthException catch(e){
    print(e);
    return false;
  }
}

Future<UserCredential?> iniciarSesionConGoggle() async {

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<bool> subirImagen(String email, String id,File file) async {
  try{
    final storageRef = FirebaseStorage.instance.ref();

    final imagenRef = storageRef.child('imagenes-$email/$id');

    await imagenRef.putFile(file);
    return true;
  } on FirebaseAuthException catch(e){
    print(e);
    return false;
  } catch(e){
    print(e);
    return false;
  }
}

Future<bool> borrarImagen(String email, id) async {
  try{
    final storageRef = FirebaseStorage.instance.ref();
    final desertRef = storageRef.child('imagenes-$email/$id');
    await desertRef.delete();
    return true;
  } on FirebaseFirestore catch(e){
    print(e);
    return false;
  } 
}

Future<bool> subirdocumento(String email, String id, Map info) async {
  try{
    String imgPath = 'imagenes-$email/$id';
    var res = await db.collection('imagenes-$email').doc(id).set({
      "id":id,
      "titulo":info['titulo'],
      "subtitulo":info['subtitulo'],
      "imagenPath":imgPath,
    });
    return true;
  }on FirebaseException catch(e){
    print(e);
    return false;
  }
}

Future<bool> actualizarDocumento(String email, String id, Map info) async{
  try{
    final documentRef = db.collection('imagenes-$email').doc(id);
    await documentRef.update({
      "titulo": info['titulo'],
      "subtitulo": info['subtitulo'],
    });
    return true;
  } on FirebaseException catch(e){
    print(e);
    return false;
  }
}

Future<List?> getDocs(String email) async{
  try{
    List result = [];
    var querySnapshot = await db.collection('imagenes-$email').get();
    for(var docSnapshot in querySnapshot.docs){
      result.add(docSnapshot.data());
    }
    return result;
  } on FirebaseException catch(e){
    print(e);
    return null;
  }
}

Future<bool> borrarDocumento(String email, String id) async {
  try{
    await db.collection('imagenes-$email').doc(id).delete();
    return true;
  } on FirebaseFirestore catch(e){
    print(e);
    return false;
  }
}

// Future<bool> borrarDocumentoAndImagen(String email, String id) async {
//     try{
//       // Eliminacion de Imagen
//       final storageRef = FirebaseStorage.instance.ref();
//       final desertRef = storageRef.child('imagenes-$email/$id');
//       await desertRef.delete();
//       // Eliminacion de Documento
//       await db.collection('imagenes-$email').doc(id).delete();
//       return true;
//     } catch(e){
//       print(e);
//       return false;
//     }
// }

Future<String> getImage(path) async {
  try{
    final storageRef = FirebaseStorage.instance.ref();

    final imageUrl = await storageRef.child(path).getDownloadURL();
    return imageUrl;
  } on FirebaseException catch(e){
    print(e);
    return 'no hay imagen';
  }
}