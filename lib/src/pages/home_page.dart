import 'package:dresscode/src/pages/closet_page.dart';
import 'package:dresscode/src/pages/create_outfits.dart';
import 'package:dresscode/src/pages/outfits_page.dart';
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
      const OutfitsPage(),
      const Center(child: Text('Outfit pages')),
    ];

    return Scaffold(
        appBar: AppBar(title: const Text('DressCode')),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: indexBottomNavbar,
            onTap: (index) {
              ref.read(indexBottomNavbarProvider.notifier).state = index;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Garde-robe'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.cases), label: 'Outfits'),
            ]),
        floatingActionButton: ClipOval(
            child: Material(
                color: const Color(0xFF7861FF),
                elevation: 10,
                child: InkWell(
                  child: const SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.add, color: Colors.white)),
                  onTap: () {
                    if (indexBottomNavbar == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateOutfitPage()),
                      );
                    } else {
                      // open camera
                    }
                  },
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: pages[indexBottomNavbar]);
  }
}
