// Tipo de variable file
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Firebase
import '../firebase/Firebase.dart';

// Image picker
import 'package:image_picker/image_picker.dart';

class EditPage extends StatelessWidget {

  String email;
  String id;
  String titulo;
  String subtitulo;
  String imagen;

  EditPage( this.email, {super.key, required this.id, required this.titulo, required this.subtitulo, required this.imagen});


  @override
  Widget build(BuildContext context) {

    // Controllers
    TextEditingController tituloActualizado = TextEditingController(text: titulo);
    TextEditingController subtituloActualizado = TextEditingController(text: subtitulo);
    File? imagenActualizada;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context, false);
          }, 
          icon: Icon(Icons.arrow_back),
        ),
        title: const Center(child: Text('Editar imagen', style: TextStyle(fontSize: 25),)),
        actions: [
          // IconButton(
          //   onPressed: (){
          //     Navigator.pop(context);
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(email,id:id, titulo:titulo, subtitulo:subtitulo, imagen:imagen ),));
          //   }, 
          //   icon: const Icon(Icons.edit_document, size: 35,),
          // ),
          TextButton(
            onPressed: () async {
              print(tituloActualizado.text);
              print(subtituloActualizado.text);
              print(imagenActualizada);

              Map info = {
                "titulo": tituloActualizado.text,
                "subtitulo":subtituloActualizado.text,
              };
              bool? res = await showDialog(
                context: context, 
                builder: (context)  {
                  return AlertDialog(
                    title: Text('Estas seguro de que quieres actualizar la imagen ?'),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: (){
                          Navigator.pop(context, true);
                        }, 
                        child: const Text('Si', style: TextStyle(color: Colors.white),),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: (){
                          Navigator.pop(context, false);
                        }, 
                        child: const Text('No', style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  );
                },
              );
              if(res == true){
                bool res = await actualizarDocumento(email, id, info);
                if(res && imagenActualizada != null){
                  bool resImg = await subirImagen(email, id, imagenActualizada!);
                  if(resImg){
                    Navigator.pop(context, true);
                  }
                }else if(res){
                  Navigator.pop(context, true);
              }
              }
            }, 
            child: const Text('Ok', style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // color: Colors.green.shade700,
              ),
              child: Column(
                
                children: [
                  FutureBuilder(
                    future: getImage(imagen),
                    builder: (context, snapshotImg) {
                      return (snapshotImg.data != null) ? Image.network(snapshotImg.data!, width: double.infinity, fit: BoxFit.cover,) : CircularProgressIndicator(backgroundColor: Colors.red,);              
                    },
                  ),
                  const SizedBox(height: 30,),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      fixedSize: const Size(500, 50),
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    child: const Text(
                      'Seleccionar otra imagen',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                      (image != null) ? imagenActualizada = File(image.path) : null; 
                    }, 
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: tituloActualizado,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_color_text_sharp, color: Colors.green, size: 35,),
                      hintText: 'Titulo',
                      hintStyle: TextStyle(fontSize: 20,color: Colors.green),
                    ),
                    style: const TextStyle(fontSize: 22, color: Colors.black),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 40,),
                  TextField(
                    controller: subtituloActualizado,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_align_center_sharp, color: Colors.green, size: 35,),
                      hintText: 'Subtitulo',
                      hintStyle: TextStyle(fontSize: 20,color: Colors.green),
                    ),
                    style: const TextStyle(fontSize: 22, color: Colors.black),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  // Text(titulo, style: const TextStyle(fontSize: 30, color: Colors.black),),
                  // Text(subtitulo, style: const TextStyle(fontSize: 18, color: Colors.black54),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}