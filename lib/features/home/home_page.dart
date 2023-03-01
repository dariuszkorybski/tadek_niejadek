import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/features/add/add_page.dart';
import 'package:tadek_niejadek/features/auht/pages/profile_screen.dart';

import 'package:tadek_niejadek/features/details/page/details_page.dart';
import 'package:tadek_niejadek/features/game/game_first_page/game_first_page.dart';
import 'package:tadek_niejadek/features/home/cubit/home_cubit.dart';
import 'package:tadek_niejadek/models/item_model.dart';
import 'package:tadek_niejadek/repositories/items_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tadek niejadek'), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserProfile(),
              ),
            );
          },
          icon: const Icon(Icons.person),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GameFirstPage(),
              ),
            );
          },
          icon: const Icon(Icons.gamepad),
        ),
      ]),
      body: const _HomePageBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(ItemsRepository())..start(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final itemModels = state.items;
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            children: [
              for (final itemModel in itemModels)
                Dismissible(
                  key: ValueKey(itemModel.id),
                  background: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return direction == DismissDirection.endToStart;
                  },
                  onDismissed: (direction) {
                    context.read<HomeCubit>().remove(documentID: itemModel.id);
                  },
                  child: _ListViewItem(
                    itemModel: itemModel,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsPage(id: itemModel.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                    image: AssetImage(
                      itemModel.image,
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
                            itemModel.name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            itemModel.selectedDateFormatted(),
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
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
                          (itemModel.myAge().abs().toStringAsFixed(0)),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'miesięcy',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
