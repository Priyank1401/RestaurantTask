import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_task/screens/login.dart';
import 'package:restaurant_task/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              icon: const Icon(Icons.person)
          ),
          IconButton(
              onPressed: () {
                _signOut();
              },
              icon: const Icon(Icons.power_settings_new)
          )
        ],
      ),
      body: Center(
        child: Text('Welcome ! ${user?.email}'),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((onValue) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }
}
