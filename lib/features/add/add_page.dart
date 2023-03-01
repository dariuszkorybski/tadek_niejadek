import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tadek_niejadek/features/add/cubit/add_cubit.dart';
import 'package:tadek_niejadek/repositories/items_repository.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? _name;
  String? _gender;
  String? _image;
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ItemsRepository()),
      child: BlocListener<AddCubit, AddState>(
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
        child: BlocBuilder<AddCubit, AddState>(
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
                            _gender == null ||
                            _image == null ||
                            _dateTime == null
                        ? null
                        : () {
                            context.read<AddCubit>().add(
                                  _name!,
                                  _gender!,
                                  _image!,
                                  _dateTime!,
                                );
                          },
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: _AddPageBody(
                onNameChanged: (newValue) {
                  setState(() {
                    _name = newValue;
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
                onDateChanged: (newValue) {
                  setState(() {
                    _dateTime = newValue;
                  });
                },
                selectedDateFormatted: _dateTime == null
                    ? null
                    : DateFormat.MMMEd().format(_dateTime!),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  const _AddPageBody({
    Key? key,
    required this.onNameChanged,
    required this.onGenderChanged,
    required this.onImageChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onNameChanged;
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

  setState(Function() param0) {}
}
