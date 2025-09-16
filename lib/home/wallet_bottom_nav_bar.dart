import 'package:flutter/material.dart';

class WalletBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const WalletBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(bottom: 9),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.amber,
              unselectedItemColor: const Color.fromARGB(255, 111, 182, 240),
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: onTap,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.search, size: 28), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.send, size: 28), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.settings, size: 28), label: ''),
              ],
              elevation: 0,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              iconSize: 28,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
