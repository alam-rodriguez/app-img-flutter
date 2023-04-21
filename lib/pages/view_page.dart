import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Firebase
import '../firebase/Firebase.dart';
import 'edit_page.dart';

class ViewPage extends StatelessWidget {

  String email;
  String id;
  String titulo;
  String subtitulo;
  String imagen;

  ViewPage( this.email, {super.key, required this.id, required this.titulo, required this.subtitulo, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context, false);
          }, 
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text('Imagen'),
        actions: [
          IconButton(
            onPressed: () async {
              bool res = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(email,id:id, titulo:titulo, subtitulo:subtitulo, imagen:imagen ),));
              if(res){
                Navigator.pop(context, true);
              }
              // await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPage(email,id:id, titulo:titulo, subtitulo:subtitulo, imagen:imagen ),));
            }, 
            icon: const Icon(Icons.edit, size: 35,),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.green.shade700,
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: getImage(imagen),
                    builder: (context, snapshotImg) {
                      return (snapshotImg.data != null) ? Image.network(snapshotImg.data!, width: double.infinity, fit: BoxFit.cover,) : CircularProgressIndicator(backgroundColor: Colors.red,);              
                    },
                  ),
                Text(titulo, style: const TextStyle(fontSize: 30, color: Colors.black),),
                Text(subtitulo, style: const TextStyle(fontSize: 18, color: Colors.black54),),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red.shade900,
            fixedSize: const Size(500, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: const Text(
            'Borrar imagen',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          onPressed: () async {
            bool? res = await showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  title: Text('Deseas eliminar la foto ?'),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: (){
                        Navigator.pop(context, true);
                      }, 
                      child: Text('Si', style: TextStyle(color: Colors.white),),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: (){
                        Navigator.pop(context, false);
                      }, 
                      child: Text('No', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                );
              },
            );
            print(res);
            if(res == true){
              await borrarImagen(email, id);
              await borrarDocumento(email, id);
              Navigator.pop(context,true);
            }
          }, 
        ),
      ),
    );
  }
}