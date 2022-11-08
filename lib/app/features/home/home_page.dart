import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tadek_niejadek/app/features/adding/adding_child_page.dart';
import 'package:tadek_niejadek/app/features/game/game_first_page/game_first_page.dart';
import 'package:tadek_niejadek/app/features/home/child/child_list.dart';
import 'package:tadek_niejadek/app/features/pages/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Tadek niejadek'),
        ),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const ChildList();
        }
        if (currentIndex == 1) {
          return const UserProfile();
        }
        if (currentIndex == 2) {
          return const GameFirstPage();
        }
        if (currentIndex == 3) {
          return AddingChildPage(onSave: () {
            setState(() {
              currentIndex = 0;
            });
          });
        }
        return const UserProfile();
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.child_friendly),
            label: 'Dzieci',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Zagraj w grę',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj dziecko',
          ),
        ],
      ),
    );
  }
}
