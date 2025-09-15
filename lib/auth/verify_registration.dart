import 'package:flutter/material.dart';

class VerifyRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color amarilloBanco = const Color(0xFFF1C40F);
    final TextEditingController _pinController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 40),
          SizedBox(height: 30),
          Center(
            child: Icon(Icons.account_balance, color: amarilloBanco, size: 60),
          ),
          SizedBox(height: 30),
          Text(
            'Verificar Registro',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: amarilloBanco,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Te hemos enviado un email con el PIN de verificación.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      controller: _pinController,
                      decoration: InputDecoration(
                        labelText: 'PIN de 6 dígitos',
                        labelStyle: TextStyle(color: amarilloBanco),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: amarilloBanco),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: amarilloBanco,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: amarilloBanco,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          'Verificar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
