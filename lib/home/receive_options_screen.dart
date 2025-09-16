import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveOptionsScreen extends StatelessWidget {
  const ReceiveOptionsScreen({Key? key}) : super(key: key);

  final String _publicAddress = '1A2b3C4d5E6f7G8h9I0jK1l2M3n4O5p6Q7r8S9t0';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
