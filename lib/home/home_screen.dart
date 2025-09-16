import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login.dart';
import 'search_screen.dart';
import 'wallet_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _historialController = ScrollController();
  bool _hasToken = false;
  bool _loading = true;

  int _selectedIndex = 0;

  final Color amarilloBanco = const Color(0xFFF1C40F);

  // Datos demo
  final double bitcoinAmount = 0.5234;
  final double bitcoinToUsd = 27000.0; // Ejemplo de cambio
  late final double usdAmount = bitcoinAmount * bitcoinToUsd;

  final List<Map<String, dynamic>> historial = [
    {"tipo": "Recibido", "cantidad": 0.1, "estado": "Completado"},
    {"tipo": "Enviado", "cantidad": 0.05, "estado": "Completado"},
    {"tipo": "En proceso", "cantidad": 0.02, "estado": "Pendiente"},
    {"tipo": "Recibido", "cantidad": 0.3, "estado": "Completado"},
    {"tipo": "Enviado", "cantidad": 0.02, "estado": "Completado"},
    {"tipo": "En proceso", "cantidad": 0.01, "estado": "Pendiente"},
  ];

  // Para el SearchScreen
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (!mounted) return;
    setState(() {
      _hasToken = token != null && token.isNotEmpty;
      _loading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasToken) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Contenido de las páginas
    final List<Widget> _pages = [
      // Página principal (antes body de HomeScreen)
      Stack(
        children: [
          // Halos sutiles en el fondo (amarillo con opacidad)
          Positioned(
            top: -120,
            left: -80,
            child: _YellowGlow(
              amarillo: amarilloBanco,
              radius: 280,
              opacity: 0.07,
            ),
          ),
          Positioned(
            bottom: -160,
            right: -100,
            child: _YellowGlow(
              amarillo: amarilloBanco,
              radius: 340,
              opacity: 0.05,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                children: [
                  // Header minimal
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: amarilloBanco.withOpacity(0.5),
                            width: 1.2,
                          ),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: amarilloBanco,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        tooltip: 'Opciones',
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Tarjeta de saldo (glass + borde amarillo)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: amarilloBanco.withOpacity(0.25),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: amarilloBanco.withOpacity(0.12),
                              blurRadius: 18,
                              spreadRadius: 0.2,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${bitcoinAmount.toStringAsFixed(4)} BTC',
                              style: TextStyle(
                                color: amarilloBanco,
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '≈ ${usdAmount.toStringAsFixed(2)} USD',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.90),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // === NUEVOS BOTONES: ENVIAR / RECIBIR ===
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          amarillo: amarilloBanco,
                          icon: Icons.call_made, // salida
                          label: 'Enviar',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enviar presionado'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ActionButton(
                          amarillo: amarilloBanco,
                          icon: Icons.call_received, // entrada
                          label: 'Recibir',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Recibir presionado'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // === FIN NUEVOS BOTONES ===
                  // Título historial
                  Row(
                    children: [
                      Text(
                        'Historial',
                        style: TextStyle(
                          color: amarilloBanco,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.history,
                        color: Colors.white.withOpacity(0.8),
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Lista de historial en cards
                  Expanded(
                    child: Scrollbar(
                      controller: _historialController,
                      thumbVisibility: true,
                      child: ListView.separated(
                        controller: _historialController,
                        padding: EdgeInsets.zero,
                        itemCount: historial.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = historial[index];
                          final String tipo = item['tipo'];
                          final double cantidad = item['cantidad'];
                          final String estado = item['estado'];
                          final IconData leadingIcon = switch (tipo) {
                            'Recibido' => Icons.call_received,
                            'Enviado' => Icons.call_made,
                            _ => Icons.hourglass_top,
                          };
                          return _HistoryCard(
                            amarillo: amarilloBanco,
                            leadingIcon: leadingIcon,
                            title: '$tipo ${cantidad.toStringAsFixed(8)} BTC',
                            subtitle: estado,
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
      // Página de búsqueda
      SearchScreen(controller: _searchController),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: WalletBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

class _Pill extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color amarillo;

  const _Pill({required this.text, required this.icon, required this.amarillo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: amarillo.withOpacity(0.35), width: 1),
        color: Colors.white.withOpacity(0.02),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: amarillo),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final Color amarillo;
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _HistoryCard({
    required this.amarillo,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Detectar si el estado es 'Completado'
    final String estado = subtitle.trim().toLowerCase();
    final bool isCompletado = estado == 'completado';
    final bool isPendiente = estado == 'pendiente';
    final Color verde = Colors.greenAccent.shade400;
    final Color naranja = Colors.orangeAccent.shade200;
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: amarillo.withOpacity(0.18), width: 1),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: amarillo.withOpacity(0.12),
          highlightColor: amarillo.withOpacity(0.06),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Icono con aro amarillo
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: amarillo.withOpacity(0.6),
                      width: 1.4,
                    ),
                  ),
                  child: Center(
                    child: Icon(leadingIcon, color: amarillo, size: 22),
                  ),
                ),
                const SizedBox(width: 12),

                // Títulos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isCompletado
                                    ? verde
                                    : isPendiente
                                    ? naranja
                                    : amarillo.withOpacity(0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              subtitle,
                              style: TextStyle(
                                color: isCompletado
                                    ? verde
                                    : isPendiente
                                    ? naranja
                                    : Colors.white.withOpacity(0.9),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withOpacity(0.35),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// === WIDGET REUTILIZABLE PARA LOS BOTONES DE ACCIÓN ===
class _ActionButton extends StatelessWidget {
  final Color amarillo;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.amarillo,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22, color: amarillo),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.04),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: amarillo.withOpacity(0.35), width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
