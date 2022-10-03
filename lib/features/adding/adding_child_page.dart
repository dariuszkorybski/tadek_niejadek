import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tadek_niejadek/features/adding/cubit/adding_cubit.dart';

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
  String? _height;
  String? _weight;
  String? _gender;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingCubit(),
      child: BlocListener<AddingCubit, AddingState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddingCubit, AddingState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Dodaj dziecko'),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<AddingCubit>().add(
                            _name!,
                            _dateTime!,
                            _height!,
                            _weight!,
                            _gender!,
                            _imageUrl!,
                          );
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      (Icons.back_hand),
                    ),
                  )
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
                selectedDateFormatted: _dateTime == null
                    ? null
                    : DateFormat.MMMEd().format(_dateTime!),
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
          },
        ),
      ),
    );
  }
}

class _AddChildBody extends StatelessWidget {
  const _AddChildBody({
    Key? key,
    required this.onNameChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
    required this.onHeightChanged,
    required this.onWeightChanged,
    required this.onGenderChanged,
    required this.onImageUrlChanged,
  }) : super(key: key);

  final Function(String) onNameChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;
  final Function(String) onHeightChanged;
  final Function(String) onWeightChanged;
  final Function(String) onGenderChanged;
  final Function(String) onImageUrlChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      children: [
        TextField(
          onChanged: onNameChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Podaj imię dziecka',
            label: Text('Imię'),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: onGenderChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Kobieta/Męzczyzna [K/M]',
            label: Text('Płeć'),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: onHeightChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Podaj wzrost dziecka',
            label: Text('Wzrost [cm]'),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: onWeightChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Podaj wagę dziecka',
            label: Text('Waga [kg]'),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: onImageUrlChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'http:// ... .jpg',
            label: Text('Image URL'),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.utc(2000, 1, 1),
              lastDate: DateTime.now().add(
                const Duration(days: 365 * 10),
              ),
            );
            onDateChanged(selectedDate);
          },
          child: Text(selectedDateFormatted ?? 'Wybierz datę'),
        ),
      ],
    );
  }
}
