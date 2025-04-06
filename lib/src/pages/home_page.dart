import 'package:dresscode/src/pages/closet_page.dart';
import 'package:dresscode/src/providers/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    final pages = [
      const ClosetPage(),
      const Center(child: Text('Outfit pages')),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('DressCode')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Garde-robe'),
          BottomNavigationBarItem(icon: Icon(Icons.cases), label: 'Tenues'),
        ]
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: Color(0xFF7861FF),
          elevation: 10,
          child: InkWell(
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.add, color: Colors.white)
            ),
            onTap: () {
              // open camera
            },
          )
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[indexBottomNavbar]
    );
  }
}