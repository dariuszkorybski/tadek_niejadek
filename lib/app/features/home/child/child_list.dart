import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/app/features/details/page/details_page.dart';
import 'package:tadek_niejadek/models/child_model.dart';
import 'package:tadek_niejadek/repositories/child_repository.dart';

import 'cubit/child_cubit.dart';

class ChildList extends StatelessWidget {
  const ChildList({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => ChildCubit(ChildRepository())..start(),
      child: BlocBuilder<ChildCubit, ChildState>(
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
                  key: ValueKey(childModel.id),
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
                        .read<ChildCubit>()
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
    ));
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
                color: Colors.red,
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
