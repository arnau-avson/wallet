import 'dart:ui';
import 'package:flutter/material.dart';
import 'components/edit_username_modal.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color amarilloBanco = const Color(0xFFF1C40F);
    final Color rojoCerrar = Colors.redAccent.shade700;
    final double glowRadius = 220;
  String username = 'Usuario';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Glow superior
          Positioned(
            top: -100,
            left: -60,
            child: _YellowGlow(amarillo: amarilloBanco, radius: glowRadius),
          ),
          // Glow inferior
          Positioned(
            bottom: -120,
            right: -80,
            child: _YellowGlow(
              amarillo: amarilloBanco,
              radius: glowRadius + 60,
              opacity: 0.06,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Usuario editable
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 28.0,
                      ), // Más padding top y bottom
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: amarilloBanco,
                              size: 22,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: EditUsernameModal(
                                    initialValue: username,
                                    onSave: (nuevoNombre) {
                                      // Aquí puedes guardar el nuevo nombre
                                      // Por ejemplo, usando setState en un StatefulWidget
                                    },
                                  ),
                                ),
                              );
                            },
                            tooltip: 'Editar nombre',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Opciones generales
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: amarilloBanco.withOpacity(0.18),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: amarilloBanco.withOpacity(0.10),
                                blurRadius: 16,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  18,
                                  10,
                                  0,
                                  2,
                                ),
                                child: Text(
                                  'General',
                                  style: TextStyle(
                                    color: amarilloBanco,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.currency_exchange,
                                  color: amarilloBanco,
                                ),
                                title: const Text(
                                  'Cambiar moneda de comparación',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Sección Aprende
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: amarilloBanco.withOpacity(0.18),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: amarilloBanco.withOpacity(0.10),
                                blurRadius: 16,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  18,
                                  10,
                                  0,
                                  2,
                                ),
                                child: Text(
                                  'Aprende',
                                  style: TextStyle(
                                    color: amarilloBanco,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.lightbulb,
                                  color: amarilloBanco,
                                ),
                                title: const Text(
                                  'Consejos y recursos',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Opciones de seguridad y privacidad
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: amarilloBanco.withOpacity(0.18),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: amarilloBanco.withOpacity(0.10),
                                blurRadius: 16,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  18,
                                  10,
                                  0,
                                  2,
                                ),
                                child: Text(
                                  'Seguridad y privacidad',
                                  style: TextStyle(
                                    color: amarilloBanco,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.lock, color: amarilloBanco),
                                title: const Text(
                                  'Cambiar PIN',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.privacy_tip,
                                  color: amarilloBanco,
                                ),
                                title: const Text(
                                  'Política de privacidad',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Sección Datos privados
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: amarilloBanco.withOpacity(0.18),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: amarilloBanco.withOpacity(0.10),
                                blurRadius: 16,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  18,
                                  10,
                                  0,
                                  2,
                                ),
                                child: Text(
                                  'Datos privados',
                                  style: TextStyle(
                                    color: amarilloBanco,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.shield,
                                  color: amarilloBanco,
                                ),
                                title: const Text(
                                  'Gestionar mis datos',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Sección de cuenta (cerrar sesión y eliminar cuenta)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: rojoCerrar.withOpacity(0.18),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: rojoCerrar.withOpacity(0.10),
                                blurRadius: 16,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  18,
                                  10,
                                  0,
                                  2,
                                ),
                                child: Text(
                                  'Cuenta',
                                  style: TextStyle(
                                    color: rojoCerrar,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Cerrar sesión',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                                tileColor: Colors.transparent,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  'Eliminar cuenta',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                                tileColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
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

class _YellowGlow extends StatelessWidget {
  final Color amarillo;
  final double radius;
  final double opacity;
  const _YellowGlow({
    required this.amarillo,
    required this.radius,
    this.opacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [amarillo.withOpacity(opacity), Colors.transparent],
        ),
      ),
    );
  }
}
