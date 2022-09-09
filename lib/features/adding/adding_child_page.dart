import 'dart:ffi';

import 'package:flutter/material.dart';

class AddingChildPage extends StatefulWidget {
  const AddingChildPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddingChildPage> createState() => _AddingChildPageState();
}

class _AddingChildPageState extends State<AddingChildPage> {
  String? _name;
  DateTime? _dateTime;
  Double? _height;
  Double? _weight;
  Bool? _gender;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj dziecko'),
        actions: [
          IconButton(onPressed: onPressed, icon: const Icon(Icons.add))
        ],
      ),
      body: _AddChildBody(
        onNameChanged: (newValue) {
          setState(() {
            _name = newValue;
          });
        },
        onDateChanged: (newValue) {
          setState(() {
            _dateTime = newValue;
          });
        },
        selectedDateFormatted: _dateTime?.toIso8601String(),
        onHeightChanged: (newValue) {
          setState(() {
            _height = newValue;
          });
        },
        onWeightChanged: (newValue) {
          setState(() {
            _weight = newValue;
          });
        },
        onGenderChanged: (newValue) {
          setState(() {
            _gender = newValue;
          });
        },
        onImageUrlChanged: (newValue) {
          setState(() {
            _imageUrl = newValue;
          });
        },
      ),
    );
  }
}

class _AddChildBody extends StatelessWidget {
  const _AddChildBody({
    Key? key,
    required this.onNameChanged,
    required this.onDateChanged,
    required this.selectedDateFormatted,
    required this.onHeightChanged,
    required this.onWeightChanged,
    required this.onGenderChanged,
    required this.onImageUrlChanged,
  }) : super(key: key);

  final Function(String) onNameChanged;
  final Function(DateTime) onDateChanged;
  final String selectedDateFormatted;
  final Function(Double) onHeightChanged;
  final Function(Double) onWeightChanged;
  final Function(Bool) onGenderChanged;
  final Function(String) onImageUrlChanged;

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
