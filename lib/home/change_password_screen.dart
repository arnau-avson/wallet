import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showRepeat = false;
  String? _error;

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica real de cambio de password
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña cambiada correctamente')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final amarilloBanco = const Color(0xFFF1C40F);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Cambiar contraseña', style: TextStyle(color: amarilloBanco)),
        iconTheme: IconThemeData(color: amarilloBanco),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              TextFormField(
                controller: _currentController,
                obscureText: !_showCurrent,
                decoration: InputDecoration(
                  labelText: 'Contraseña actual',
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                    icon: Icon(_showCurrent ? Icons.visibility : Icons.visibility_off, color: amarilloBanco),
                    onPressed: () => setState(() => _showCurrent = !_showCurrent),
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce tu contraseña actual';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newController,
                obscureText: !_showNew,
                decoration: InputDecoration(
                  labelText: 'Nueva contraseña',
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                    icon: Icon(_showNew ? Icons.visibility : Icons.visibility_off, color: amarilloBanco),
                    onPressed: () => setState(() => _showNew = !_showNew),
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce la nueva contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _repeatController,
                obscureText: !_showRepeat,
                decoration: InputDecoration(
                  labelText: 'Repite la nueva contraseña',
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                    icon: Icon(_showRepeat ? Icons.visibility : Icons.visibility_off, color: amarilloBanco),
                    onPressed: () => setState(() => _showRepeat = !_showRepeat),
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Repite la nueva contraseña';
                  }
                  if (value != _newController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                ),
              ],
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: amarilloBanco,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Cambiar contraseña',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
