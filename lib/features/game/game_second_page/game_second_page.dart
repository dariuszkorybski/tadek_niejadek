import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameSecondPage extends StatelessWidget {
  const GameSecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final result = random.nextBool();
    return Scaffold(
      backgroundColor: result == true ? Colors.pink : Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (result == true)
              Text(
                'Mama!!!',
                style: GoogleFonts.poppins(
                    fontSize: 50,
                    color: result == true ? Colors.yellow : Colors.indigo),
              ),
            if (result == false)
              Text(
                'Tata!!!',
                style: GoogleFonts.poppins(
                  fontSize: 50,
                ),
              ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cofnij'))
          ],
        ),
      ),
    );
  }
}
