import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Image picket
import 'package:image_picker/image_picker.dart';

// Fiebase
import '../firebase/Firebase.dart';

// uuid
import 'package:uuid/uuid.dart';

class AddPage extends StatelessWidget {

  String email;

  AddPage({super.key, required this.email});

  TextEditingController titulo = TextEditingController();
  TextEditingController subtitulo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    File? image;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Agregar Imagen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titulo,
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
              controller: subtitulo,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.format_align_center_sharp, color: Colors.green, size: 35,),
                hintText: 'Subtitulo',
                hintStyle: TextStyle(fontSize: 20,color: Colors.green),
              ),
              style: const TextStyle(fontSize: 22, color: Colors.black),
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 60,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(500, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                'Seleccionar una imagen',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                XFile? res = await picker.pickImage(source: ImageSource.gallery);
                res != null ? image = File(res.path) : null;
                // image = File(res!.path);
                // print(image);
              }, 
            ),
            const SizedBox(height: 60,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(500, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                'Guardar imagen',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onPressed: () async {
                if(titulo.text.length < 3 || subtitulo.text.length < 3){
                  showDialog(context: context, builder: (context) {
                    return const AlertDialog(
                      title: Text('Error'),
                      content: Text('El titulo y el subtitulo deben de tener por lo menos 3 caracteres.'),
                    );
                  },);
                }else if(image == null){
                  showDialog(context: context, builder: (context) {
                    return const AlertDialog(
                      title: Text('Error'),
                      content: Text('Debe de seleccionar una imagen obligatoriamente.'),
                    );
                  },);
                }else {
                  var uuid = Uuid();
                  String id = uuid.v4(); 
                  bool resImg = await subirImagen(email, id, image!);
                  if(resImg){
                    Map info = {
                      "titulo":titulo.text,
                      "subtitulo": subtitulo.text,
                    };
                    bool resDoc = await subirdocumento(email, id, info);
                    // if(resDoc){
                    Navigator.pop(context);
                    // }
                  }
                }
              }, 
            ),
          ],
        ),
      ),
    );
  }
}