import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/app/features/details/cubit/details_cubit.dart';
import 'package:tadek_niejadek/models/child_model.dart';
import 'package:tadek_niejadek/repositories/child_repository.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Can\'t Wait 🤩'),
      ),
      body: BlocProvider(
        create: (context) =>
            DetailsCubit(ChildRepository())..getChildWithID(id),
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final childModel = state.childModel;
            if (childModel == null) {
              return const CircularProgressIndicator();
            }
            return ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              children: [
                _ListViewChild(
                  childModel: childModel,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListViewChild extends StatelessWidget {
  const _ListViewChild({
    Key? key,
    required this.childModel,
  }) : super(key: key);

  final ChildModel childModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: Column(children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: NetworkImage(
                  childModel.name,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        childModel.gender,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        childModel.height.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      childModel.weight.toString(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('weight'),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
