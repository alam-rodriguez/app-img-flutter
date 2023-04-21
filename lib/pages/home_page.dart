// Material
import 'package:flutter/material.dart';

// Firebase
import '../firebase/Firebase.dart';

// Pages
import 'package:img_app/pages/view_page.dart';

class HomePage extends StatefulWidget {

  String email;

  HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Img-App'),
        actions: [
          IconButton(onPressed: () async {
            bool? res = await showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  title: Text('Deseas cerrar la sesion'),
                  content: Text('Estas seguro de que quieres cerrar la sesion ?'),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: (){
                        Navigator.pop(context,true);
                      }, 
                    child: const Text('Si', style: TextStyle(color: Colors.white),),
                  ),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: (){
                        Navigator.pop(context,false);
                      }, 
                      child: const Text('No', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                );
              },
            );
            if(res != null && res == true){
              bool resf = await cerrarSesion();
              if(resf){
                Navigator.popAndPushNamed(context, '/login');
              }
            }
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: FutureBuilder(
        future: getDocs(widget.email),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data?.length == 0){
            return const Center(child: Text('No hay ninguna imagen.', style: TextStyle(fontSize: 25),),);
          }
            else if(snapshot.hasData){
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.green.shade700),
                      onPressed: () async {
                        // print(snapshot.data?[index]['id']);
                        // print(snapshot.data?[index]['titulo']);
                        // print(snapshot.data?[index]['subtitulo']);
                        // print(snapshot.data?[index]['imagenPath']);
                        bool res = await Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage(widget.email,id:snapshot.data?[index]['id'], titulo:snapshot.data?[index]['titulo'], subtitulo:snapshot.data?[index]['subtitulo'], imagen:snapshot.data?[index]['imagenPath'] ),));
                        if(res) setState(() {});

                      }, 
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: getImage(snapshot.data![index]['imagenPath']),
                            builder: (context, snapshotImg) {
                              return (snapshotImg.data != null && snapshotImg.data != 'no hay imagen') ? Image.network(snapshotImg.data!, fit: BoxFit.cover, width: double.infinity,height: 300,) : CircularProgressIndicator(backgroundColor: Colors.red,);
                              // if(snapshotImg.data != null){
                              //   return Image.network(snapshotImg.data!);
                              // }else {
                              //   return Text('data');
                              // }
                            },
                          ),
                          Text(snapshot.data?[index]['titulo'], style: const TextStyle(fontSize: 30, color: Colors.black),),
                          Text(snapshot.data?[index]['subtitulo'],  style: const TextStyle(fontSize: 18, color: Colors.black54),),
                        ],
                      ), 
                    ),
                    const SizedBox(height: 30,),
                  ],
                );
              },
            );
          }else {
            return const CircularProgressIndicator();
          }
        }
      ),
      // body: Container(
      //   margin: EdgeInsets.all(15),
      //   child: Column(
      //     children: [
      //       TextButton(
      //         onPressed: () async {
      //           List? res = await getDocs(widget.email);
      //           if(res != null){
      //             res.forEach((card) async {
      //               String? image = await getImage(card['imagenPath']);
      //               print(image);
      //             });
      //           }
      //         }, 
      //         child: Column(
      //           children: [
      //             Image.network('https://www.adslzone.net/app/uploads-adslzone.net/2019/04/borrar-fondo-imagen.jpg'),
      //             Text('Titulo', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
      //             Text('Elit excepteur commodo sint pariatur ea in nulla elit. Aliquip reprehenderit pariatur irure veniam fugiat aute est ad. Ex labore ea ex irure excepteur est consectetur do veniam. Aute ex incididunt aliqua quis. Qui sint excepteur magna dolore duis labore cupidatat irure mollit sint duis aliquip. Qui excepteur voluptate ea deserunt labore.', style: TextStyle(color: Colors.black54, fontSize: 15),)
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await Navigator.popAndPushNamed(context, '/add');
          await Navigator.pushNamed(context, '/add');
          setState(() {});
          // if(res == true){
          // }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_photo_alternate, size: 35,color: Colors.white,),
      ),
    );
  }
}