import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tadek_niejadek/app/features/game/game_second_page/game_second_page.dart';
import 'package:tadek_niejadek/app/features/home/child/child_list.dart';

class GameFirstPage extends StatelessWidget {
  const GameFirstPage({
    Key? key,
    required this.back,
  }) : super(key: key);

  final Function back;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
            ),
            Text(
              'Kto dziś usypia nasze Maleństwo ?',
              style: GoogleFonts.poppins(
                fontSize: 23,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                child: const Text('Sprawdź :)'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const GameSecondPage(),
                  ));
                }),
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
                child: const Text('Powrót do listy'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const ChildList(),
                  ));
                })
          ],
        ),
      ),
    );
  }
}
