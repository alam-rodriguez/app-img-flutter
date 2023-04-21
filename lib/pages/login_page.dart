// Material
import 'package:flutter/material.dart';

// Firebase
import '../firebase/Firebase.dart';

class LoginPage extends StatelessWidget {

  String email;

  LoginPage({super.key, required this.email});

  // Controles
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(  
          child: Text(
            'Login-App',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: Colors.green, size: 35,),
                hintText: 'Correo electronico',
                hintStyle: TextStyle(fontSize: 20,color: Colors.green),
              ),
              style: const TextStyle(fontSize: 22, color: Colors.black),
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30,),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password, color: Colors.green, size: 35,),
                hintText: 'Contraseña de correo',
                hintStyle: TextStyle(fontSize: 20,color: Colors.green),
              ),
              style: const  TextStyle(fontSize: 22, color: Colors.black),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(height: 60,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(500, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                'Registrar usuario',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onPressed: () async {
                if(emailController.text.length < 5){
                  Alert(context, 'Error en Email','El email debe de tener un minimo de 5 caracteres, pero el email ingresado contiene ${emailController.text.length} caracteres, por favor intentelo de nuevo y hagalo bien.');
                }else if(password.text.length < 8){
                  Alert(context, 'Error en contraseña', 'La contraseña solo tiene ${password.text.length} caracteres, por favor ingrese la contraseña nueva mente y ingrese por lo menos 8 caracteres.');
                }else {
                  String? res = await createUser(emailController.text,password.text);
                  if(res == emailController.text){
                    email = res!;
                    print(res);
                    Navigator.popAndPushNamed(context, '/home');
                  }
                }
              }, 
            ),
            const SizedBox(height: 35,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(500, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                'Iniciar Sesion',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onPressed: () async {
                if(emailController.text.length < 5){
                  Alert(context, 'Error en Email','El email debe de tener un minimo de 5 caracteres, pero el email ingresado contiene ${emailController.text.length} caracteres, por favor intentelo de nuevo y hagalo bien.');
                }else if(password.text.length < 8){
                  Alert(context, 'Error en contraseña', 'La contraseña solo tiene ${password.text.length} caracteres, por favor ingrese la contraseña nueva mente y ingrese por lo menos 8 caracteres.');
                }else {
                  String? res = await iniciarSesion(emailController.text,password.text);
                  if(res == emailController.text){
                    email = res!;
                    print(res);
                    Navigator.popAndPushNamed(context, '/home');
                  }
                }
              }, 
            ),
            const SizedBox(height: 35,),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     backgroundColor: Colors.green,
            //     fixedSize: const Size(500, 50),
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            //   ),
            //   child: const Text(
            //     'Google',
            //     style: TextStyle(fontSize: 25, color: Colors.white),
            //   ),
            //   onPressed: () async {
            //     print(emailController.text);
            //     print(password.text);
            //     await iniciarSesionConGoggle();
            //   }, 
            // ),
          ],
        ),
      ),
    );
  }

  void Alert(BuildContext context, titulo, content) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('OK', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }
}







// style: const ButtonStyle(
              //   fixedSize: MaterialStatePropertyAll(Size(500, 50)),
              //   backgroundColor: MaterialStatePropertyAll(Colors.red),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // ),