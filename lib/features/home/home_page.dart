import 'package:flutter/material.dart';
import 'package:tadek_niejadek/features/pages/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tadek niejadek'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const Center(
            child: Text('Jeden'),
          );
        }
        if (currentIndex == 1) {
          return const UserProfile();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Dodaj dziecko',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Moje konto',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.child_friendly),
                  label: 'Dzieci',
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
