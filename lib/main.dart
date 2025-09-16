import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'auth/pin_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _shouldShowPinScreen(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return MaterialApp(
          title: 'Wallet',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: snapshot.data! ? PinEntryScreen() : HomeScreen(),
          routes: {
            '/home': (context) => HomeScreen(),
          },
        );
      },
    );
  }

  Future<bool> _shouldShowPinScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // Si hay token, mostrar pantalla de PIN
    return token != null && token.isNotEmpty;
  }
}
