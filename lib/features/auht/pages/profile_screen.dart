import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:tadek_niejadek/features/auht/pages/auth_gate.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tadek niejadek'),
        leading: BackButton(
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: ProfileScreen(
        providerConfigs: const [
          EmailProviderConfiguration(),
        ],
        actions: [
          SignedOutAction((context) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AuhtGate(),
              ),
            );
          }),
        ],
        avatarSize: 24,
      ),
    );
  }
}
