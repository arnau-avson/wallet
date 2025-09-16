import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinEntryScreen extends StatefulWidget {
  const PinEntryScreen({super.key});

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen>
    with SingleTickerProviderStateMixin {
  final Color amarilloBanco = const Color(0xFFF1C40F);
  final List<String> _pin = [];

  late AnimationController _shakeController;
  Animation<double>? _shake;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    // Shake amortiguado (izq-der con pérdida)
    _shake = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0, end: 18), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 18, end: -14), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -14, end: 10), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 10, end: -6), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -6, end: 0), weight: 1),
      ],
    ).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onKeyTap(String value) {
    if (_pin.length < 4) {
      HapticFeedback.lightImpact();
      setState(() => _pin.add(value));
      if (_pin.length == 4) {
        Future.delayed(const Duration(milliseconds: 160), _verifyPin);
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      HapticFeedback.selectionClick();
      setState(() => _pin.removeLast());
    }
  }

  void _clearAll() {
    if (_pin.isNotEmpty) {
      HapticFeedback.mediumImpact();
      setState(_pin.clear);
    }
  }

  void _verifyPin() {
    if (_pin.join() == '1234') {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      _shakeController.forward(from: 0);
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(_pin.clear);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isSmall = size.width < 360;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Halo/ambient glow (mismo amarillo con opacidad)
          Positioned(
            top: -120,
            left: -80,
            child: _YellowGlow(amarillo: amarilloBanco, radius: 280),
          ),
          Positioned(
            bottom: -140,
            right: -100,
            child: _YellowGlow(
              amarillo: amarilloBanco,
              radius: 320,
              opacity: 0.06,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                // Icono / logo
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: amarilloBanco.withOpacity(0.5),
                        width: 1.2,
                      ),
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: amarilloBanco,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Introduce tu PIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: amarilloBanco,
                    fontSize: isSmall ? 18 : 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 22),

                // Indicadores del PIN con shake
                AnimatedBuilder(
                  animation: _shakeController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset((_shake?.value ?? 0), 0),
                      child: child,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (i) {
                      final filled = i < _pin.length;
                      final scale = filled ? 1.15 : 1.0;
                      return Transform.scale(
                        scale: scale,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: filled ? amarilloBanco : Colors.black,
                            border: Border.all(
                              color: filled
                                  ? Colors.transparent
                                  : amarilloBanco,
                              width: 2,
                            ),
                            boxShadow: filled
                                ? [
                                    BoxShadow(
                                      color: amarilloBanco.withOpacity(0.45),
                                      blurRadius: 16,
                                      spreadRadius: 0.5,
                                    ),
                                  ]
                                : [],
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const Spacer(),

                // Teclado estilo tarjeta translúcida
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: amarilloBanco.withOpacity(0.25),
                            width: 1,
                          ),
                        ),
                        child: _NumPad(
                          amarillo: amarilloBanco,
                          onNumber: _onKeyTap,
                          onBackspace: _onBackspace,
                          onLongBackspace: _clearAll,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Glow circular reutilizable (mismo amarillo con opacidades)
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

/// Teclado numérico con botones circulares animados (solo negro/amarillo)
class _NumPad extends StatelessWidget {
  final Color amarillo;
  final void Function(String) onNumber;
  final VoidCallback onBackspace;
  final VoidCallback onLongBackspace;

  const _NumPad({
    required this.amarillo,
    required this.onNumber,
    required this.onBackspace,
    required this.onLongBackspace,
  });

  @override
  Widget build(BuildContext context) {
    const rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['<', '0', ''],
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in rows)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((val) {
              if (val.isEmpty) return const SizedBox(width: 76, height: 76);
              if (val == '<') {
                return _NumKey(
                  label: '',
                  amarillo: amarillo,
                  icon: Icons.backspace,
                  onTap: onBackspace,
                  onLongPress: onLongBackspace,
                );
              }
              return _NumKey(
                label: val,
                amarillo: amarillo,
                onTap: () => onNumber(val),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class _NumKey extends StatefulWidget {
  final String label;
  final IconData? icon;
  final Color amarillo;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _NumKey({
    required this.label,
    required this.amarillo,
    required this.onTap,
    this.icon,
    this.onLongPress,
  });

  @override
  State<_NumKey> createState() => _NumKeyState();
}

class _NumKeyState extends State<_NumKey> with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 90),
  );
  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 0.94,
  ).animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut));

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  void _down(_) => _pressCtrl.forward();
  void _up(_) => _pressCtrl.reverse();

  @override
  Widget build(BuildContext context) {
    final isBackspace = widget.icon != null;
    return Padding(
      padding: const EdgeInsets.all(9),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _down,
        onTapUp: _up,
        onTapCancel: () => _pressCtrl.reverse(),
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: ScaleTransition(
          scale: _scale,
          child: isBackspace
              ? SizedBox(
                  width: 76,
                  height: 76,
                  child: Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(widget.icon, color: widget.amarillo, size: 28),
                    ),
                  ),
                )
              : Material(
                  color: Colors.black,
                  shape: const CircleBorder(),
                  child: Ink(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.amarillo, width: 1.6),
                      boxShadow: [
                        BoxShadow(
                          color: widget.amarillo.withOpacity(0.10),
                          blurRadius: 18,
                        ),
                      ],
                    ),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      splashColor: widget.amarillo.withOpacity(0.15),
                      highlightColor: widget.amarillo.withOpacity(0.08),
                      onTap: widget.onTap,
                      onLongPress: widget.onLongPress,
                      child: Center(
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            color: widget.amarillo,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
