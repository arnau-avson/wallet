import 'package:flutter/material.dart';

class TransactionDetailModal extends StatelessWidget {
  final Color amarilloBanco;
  final String tipo;
  final double cantidad;
  final String estado;
  final String direccionPublica;

  const TransactionDetailModal({
    Key? key,
    required this.amarilloBanco,
    required this.tipo,
    required this.cantidad,
    required this.estado,
    this.direccionPublica = '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = MediaQuery.of(context).size.height * 0.9;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        tipo == 'Recibido'
                            ? Icons.call_received
                            : tipo == 'Enviado'
                            ? Icons.call_made
                            : Icons.hourglass_top,
                        color: amarilloBanco,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        tipo,
                        style: TextStyle(
                          color: amarilloBanco,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: estado.toLowerCase() == 'completado'
                              ? Colors.green.withOpacity(0.15)
                              : Colors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          estado,
                          style: TextStyle(
                            color: estado.toLowerCase() == 'completado'
                                ? Colors.greenAccent
                                : Colors.orangeAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '${cantidad.toStringAsFixed(8)} BTC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '≈ ${(cantidad * 27000).toStringAsFixed(2)} USD',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: amarilloBanco,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Dirección pública:',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: amarilloBanco.withOpacity(0.18),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          direccionPublica.substring(0, 5) + '...' +
                              direccionPublica.substring(
                                direccionPublica.length - 3,
                              ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.copy, color: Colors.white38, size: 18),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: const Color(0xFF23272F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Dirección completa',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 18),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: SelectableText(
                                          direccionPublica,
                                          style: const TextStyle(
                                            color: Colors.amber,
                                            fontFamily: 'monospace',
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('Cerrar'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.visibility, color: Colors.white38, size: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: amarilloBanco,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text('Fecha:', style: TextStyle(color: Colors.white70)),
                      const SizedBox(width: 6),
                      Text('16/09/2025', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.numbers, color: amarilloBanco, size: 18),
                      const SizedBox(width: 8),
                      Text('Hash:', style: TextStyle(color: Colors.white70)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '0xFAKE1234567890',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.close),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: amarilloBanco,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      label: const Text('Cerrar'),
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
