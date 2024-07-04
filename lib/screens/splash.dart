import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_task/screens/home.dart';
import 'package:restaurant_task/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      FirebaseAuth.instance.currentUser == null
          ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()))
          : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Restaurant Task'),
      ),
    );
  }
}
