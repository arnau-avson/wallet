import 'package:flutter/material.dart';
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


class ChangePinStep1Screen extends StatefulWidget {
  const ChangePinStep1Screen({Key? key}) : super(key: key);

  @override
  State<ChangePinStep1Screen> createState() => _ChangePinStep1ScreenState();
}

class _ChangePinStep1ScreenState extends State<ChangePinStep1Screen> {
  final Color amarilloBanco = const Color(0xFFF1C40F);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  void _goToPinEntry() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ChangePinEntryScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Cambiar PIN', style: TextStyle(color: amarilloBanco)),
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
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce tu contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'PIN recibido por correo',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce el PIN recibido';
                  }
                  if (value.length < 4) {
                    return 'El PIN debe tener al menos 4 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _goToPinEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: amarilloBanco,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Continuar',
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
    );
  }
}


class ChangePinEntryScreen extends StatefulWidget {
  const ChangePinEntryScreen({Key? key}) : super(key: key);

  @override
  State<ChangePinEntryScreen> createState() => _ChangePinEntryScreenState();
}

class _ChangePinEntryScreenState extends State<ChangePinEntryScreen> {
  final Color amarilloBanco = const Color(0xFFF1C40F);
  final List<String> _pin = <String>[];
  final List<bool> _showDigit = <bool>[];
  String? _error;

  void _onKeyTap(String value) {
    if (_pin.length < 8) {
      setState(() {
        _pin.add(value);
        _showDigit.add(true);
      });
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted && _showDigit.length == _pin.length) {
          setState(() {
            _showDigit[_showDigit.length - 1] = false;
          });
        }
      });
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
        _showDigit.removeLast();
      });
    }
  }

  void _clearAll() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.clear();
        _showDigit.clear();
      });
    }
  }

  void _saveNewPin() {
    if (_pin.length < 4) {
      setState(() {
        _error = 'El nuevo PIN debe tener al menos 4 dígitos';
      });
      return;
    }
    // Aquí guardarías el nuevo PIN
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PIN cambiado correctamente')),
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Nuevo PIN', style: TextStyle(color: amarilloBanco)),
        iconTheme: IconThemeData(color: amarilloBanco),
      ),
      body: Column(
        children: [
          Text(
            'Introduce tu nuevo PIN',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: amarilloBanco,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          // PIN arriba SIEMPRE visible, aunque esté vacío
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pin.length > 0 ? _pin.length : 4, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5), // menos separación
                  child: Text(
                    i < _pin.length
                        ? (_showDigit.length > i && _showDigit[i] ? _pin[i] : '*')
                        : '•',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                );
              }),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveNewPin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: amarilloBanco,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Guardar PIN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
