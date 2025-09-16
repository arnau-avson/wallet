import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final List<String> currencies;
  final ValueChanged<String?> onChanged;

  const CurrencyDropdown({
    Key? key,
    required this.selectedCurrency,
    required this.currencies,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: Colors.black87,
        value: selectedCurrency,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        style: const TextStyle(color: Colors.white, fontSize: 16),
        items: currencies.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Icon(Icons.attach_money, color: Colors.amber.shade700),
                const SizedBox(width: 8),
                Text(value, style: const TextStyle(color: Colors.white)),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
        menuMaxHeight: 200, // Limita la altura del desplegable (aprox. 3-4 items)
      ),
    );
  }
}
