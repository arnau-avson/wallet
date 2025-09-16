import 'package:flutter/material.dart';


class SearchScreen extends StatelessWidget {
  final TextEditingController controller;
  const SearchScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color amarilloBanco = const Color(0xFFF1C40F);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: TextField(
        controller: controller,
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
    );
  }
}
