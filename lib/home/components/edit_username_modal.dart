
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
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 60),
      decoration: const BoxDecoration(
        color: Color(0xF2000000),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      width: double.infinity,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Barra gris para deslizar
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            Text(
              'Editar nombre',
              style: TextStyle(
                color: amarilloBanco,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.07),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          topRight: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        borderSide: BorderSide(color: amarilloBanco, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          topRight: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        borderSide: BorderSide(color: amarilloBanco.withOpacity(0.3), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          topRight: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        borderSide: BorderSide(color: amarilloBanco, width: 2),
                      ),
                      hintText: 'Introduce tu nombre',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    ),
                  ),
                ),
                // Sin separación entre input y botón
                Container(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      onSave(controller.text.trim());
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: amarilloBanco,
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(48, 48),
                      maximumSize: const Size(48, 48),
                      elevation: 0,
                    ),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

// USO: Para mostrar este modal como bottom sheet, llama desde tu widget:
// showModalBottomSheet(
//   context: context,
//   isScrollControlled: true,
//   backgroundColor: Colors.transparent,
//   builder: (_) => EditUsernameModal(
//     initialValue: ...,
//     onSave: ...,
//   ),
// );
