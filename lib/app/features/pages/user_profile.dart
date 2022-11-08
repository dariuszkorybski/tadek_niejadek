import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/app/cubit/auth_cubit.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(),
            ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              child: const Text('Wyloguj'),
            ),
          ],
        ),
      ),
    );
  }
}
