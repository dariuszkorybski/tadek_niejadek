import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tadek_niejadek/features/auht/cubit/auth_cubit.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
