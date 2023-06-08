import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tdapp/screens/login_screen.dart';
import 'package:tdapp/screens/tabs_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetStorage _getStorage = GetStorage();
  @override
  void initState() {
    openNextPage(context);
    super.initState();
  }

  openNextPage(BuildContext context) {
    Timer(const Duration(milliseconds: 2000), () {
      if (_getStorage.read('token') == null ||
          _getStorage.read('token') == '') {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, TabsScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
