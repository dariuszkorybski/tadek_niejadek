import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(children: const [],),
    );
  }
}
