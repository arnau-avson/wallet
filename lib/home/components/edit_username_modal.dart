import 'package:flutter/material.dart';

class EditUsernameModal extends StatelessWidget {
  final String initialValue;
  final void Function(String) onSave;

  const EditUsernameModal({
    Key? key,
    required this.initialValue,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: initialValue);
    final Color amarilloBanco = const Color(0xFFF1C40F);
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Editar nombre',
              style: TextStyle(
                color: amarilloBanco,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.07),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: amarilloBanco, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: amarilloBanco.withOpacity(0.3), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: amarilloBanco, width: 2),
                ),
                hintText: 'Introduce tu nombre',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  onSave(controller.text.trim());
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.check, color: Colors.white),
                label: Text('Guardar', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: amarilloBanco,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
