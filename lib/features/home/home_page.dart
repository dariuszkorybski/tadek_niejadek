import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/features/adding/adding_child_page.dart';
import 'package:tadek_niejadek/features/auht/pages/user_profile.dart';
import 'package:tadek_niejadek/features/details/page/details_page.dart';
import 'package:tadek_niejadek/features/game/game_first_page/game_first_page.dart';
import 'package:tadek_niejadek/features/home/cubit/home_cubit.dart';
import 'package:tadek_niejadek/models/item_model.dart';
import 'package:tadek_niejadek/repositories/items_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

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
      body: const _ChildListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddingChildPage(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ChildListBody extends StatelessWidget {
  const _ChildListBody({
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
                  child: _ListViewChild(
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

class _ListViewChild extends StatelessWidget {
  const _ListViewChild({
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
                child: Center(
                    child: Text(
                  itemModel.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
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
                            itemModel.weight,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            itemModel.height,
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
                          itemModel.gender,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('days left'),
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
