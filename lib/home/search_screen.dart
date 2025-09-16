import 'package:flutter/material.dart';
import 'wallet_bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
// Para navegación por nombre, asegúrate de tener la ruta '/home' definida en tu MaterialApp
// Ejemplo: routes: {'/home': (context) => HomeScreen(), ...}

  @override
  Widget build(BuildContext context) {
    final Color amarilloBanco = const Color(0xFFF1C40F);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Buscar...',
            labelStyle: TextStyle(color: amarilloBanco),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: amarilloBanco),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: amarilloBanco, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.black,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      bottomNavigationBar: WalletBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
