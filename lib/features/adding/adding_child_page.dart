import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tadek_niejadek/features/adding/cubit/adding_cubit.dart';

import 'package:tadek_niejadek/repositories/items_repository.dart';

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
  String? _image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingCubit(ItemsRepository()),
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
                leading: BackButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                actions: [
                  IconButton(
                    onPressed: _name == null ||
                            _dateTime == null ||
                            _height == null ||
                            _weight == null ||
                            _gender == null
                        ? null
                        : () {
                            context.read<AddingCubit>().add(
                                  _name!,
                                  _dateTime!,
                                  _height!,
                                  _weight!,
                                  _gender!,
                                  _image!,
                                );
                          },
                    icon: const Icon(Icons.check),
                  ),
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
                onImageChanged: (newValue) {
                  setState(() {
                    _image = newValue;
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
    required this.onHeightChanged,
    required this.onGenderChanged,
    required this.onImageChanged,
    required this.onWeightChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onNameChanged;
  final Function(String) onHeightChanged;
  final Function(String) onWeightChanged;
  final Function(String) onGenderChanged;
  final Function(String) onImageChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

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
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: onWeightChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Podaj wagę dziecka',
            label: Text('Waga [kg]'),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: onImageChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'http:// ... .jpg',
            label: Text('Image'),
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