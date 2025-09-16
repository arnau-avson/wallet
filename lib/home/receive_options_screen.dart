import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveOptionsScreen extends StatefulWidget {
  const ReceiveOptionsScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveOptionsScreen> createState() => _ReceiveOptionsScreenState();
}

class _ReceiveOptionsScreenState extends State<ReceiveOptionsScreen> {
  bool _inputInEur = true;
  bool _showQR = false;
  bool _wantsToMark = false;
  final String _publicAddress = '1A2b3C4d5E6f7G8h9I0jK1l2M3n4O5p6Q7r8S9t0';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final amarilloBanco = const Color(0xFFF1C40F);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Opciones de recibir',
          style: TextStyle(color: amarilloBanco),
        ),
        iconTheme: IconThemeData(color: amarilloBanco),
      ),
      body: _showQR
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: QrImageView(
                        data: _publicAddress,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400, width: 1.2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _publicAddress,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.copy, color: Colors.grey.shade700),
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: _publicAddress),
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Dirección copiada al portapapeles'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: SingleChildScrollView(
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Opciones arriba
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              '¿Quieres marcar lo que quieres recibir?',
                              style: TextStyle(color: amarilloBanco, fontSize: 20, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Switch(
                            value: _wantsToMark,
                            onChanged: (val) => setState(() {
                              _wantsToMark = val;
                              _showQR = false;
                            }),
                            activeColor: amarilloBanco,
                          ),
                        ],
                      ),
                      if (_wantsToMark) ...[
                        const SizedBox(height: 24),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: TextField(
                                controller: _controller,
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  labelText: _inputInEur ? '¿Qué quieres recibir?' : '¿Cuánto BTC quieres recibir?',
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
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Text(_inputInEur ? '€' : '₿', style: TextStyle(color: amarilloBanco, fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: IconButton(
                                icon: Icon(Icons.swap_vert, color: amarilloBanco, size: 28),
                                onPressed: () {
                                  setState(() {
                                    _inputInEur = !_inputInEur;
                                    _controller.text = '';
                                  });
                                },
                                tooltip: 'Intercambiar moneda',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Builder(
                            builder: (context) {
                              double tasa = 0.000025 + (0.00001 * (DateTime.now().millisecond % 10));
                              double monto = double.tryParse(_controller.text.replaceAll(',', '.')) ?? 0;
                              if (_inputInEur) {
                                double btc = monto * tasa;
                                return Text(
                                  monto > 0
                                      ? '${monto.toStringAsFixed(2)} € ≈ ${btc.toStringAsFixed(8)} BTC'
                                      : '0.00 € ≈ 0.00000000 BTC',
                                  style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
                                );
                              } else {
                                double eur = monto / tasa;
                                return Text(
                                  monto > 0
                                      ? '${monto.toStringAsFixed(8)} BTC ≈ ${eur.toStringAsFixed(2)} €'
                                      : '0.00000000 BTC ≈ 0.00 €',
                                  style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 40),
                      // Botón abajo
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_wantsToMark || (_wantsToMark && _controller.text.isNotEmpty)) {
                              setState(() => _showQR = true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: amarilloBanco,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                          ),
                          child: const Text('Generar QR', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
    }
  }
