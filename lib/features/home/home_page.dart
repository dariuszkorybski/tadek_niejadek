import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/features/adding/adding_child_page.dart';
import 'package:tadek_niejadek/features/details/page/details_page.dart';
import 'package:tadek_niejadek/features/game/game_first_page/game_first_page.dart';
import 'package:tadek_niejadek/features/home/cubit/home_page_cubit.dart';

import 'package:tadek_niejadek/models/child_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Tadek niejadek'),
        ),
      ),
      body: BodyHomePage(currentIndex: currentIndex,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj dziecko',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Gra',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_friendly),
            label: 'Dzieci',
          ),
        ],
      ),
    );
  }
}

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({
    Key? key,
    required this.currentIndex, 
  }) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (currentIndex == 0) {
        return const GameFirstPage();
      }
      if (currentIndex == 1) {
        return const AddingChildPage();
      }
      if (currentIndex == 2) {
        return const GameFirstPage();
      }
      return BlocProvider(
        create: (context) => HomePageCubit()..start(),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            final childModels = state.child;
            if (childModels.isEmpty) {
              return const SizedBox.shrink();
            }
            return ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              children: [
                for (final childModel in childModels)
                  Dismissible(
                    key: ValueKey(childModel),
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
                      context
                          .read<HomePageCubit>()
                          .remove(documentID: childModel.id);
                    },
                    child: _ListViewChild(
                      childModel: childModel,
                    ),
                  ),
              ],
            );
          },
        ),
      );
    });
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsPage(id: childModel.id)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue,
            child: Text(
              childModel.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
