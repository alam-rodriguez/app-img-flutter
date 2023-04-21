// Material
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';

// Firebase Core
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Pages
import 'package:img_app/pages/home_page.dart';
import 'package:img_app/pages/login_page.dart';
import 'package:img_app/pages/add_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String email = 'ninguno';

  await FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if(user != null){
      print(user.email);
      // return user;
      email = user.email!;
    }
  });
  print(email);

  
  runApp(MyApp(email:email));

}

class MyApp extends StatelessWidget {

  String email;

  MyApp({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
      ),
      initialRoute: (email == 'ninguno') ? '/login' : '/home',
      routes: {
        '/login':(context) => LoginPage(email: email), 
        '/home':(context) => HomePage(email: email),
        '/add':(context) => AddPage(email:email),
      },
    );
  }
}