import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weight_tracker/domain/entities/weight.dart';
import 'package:weight_tracker/presentation/view_models/auth_screen_view_model.dart';
import 'package:weight_tracker/presentation/view_models/weight_screen_view_model.dart';

class WeightScreen extends ConsumerStatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeightScreenState();
}

class _WeightScreenState extends ConsumerState<WeightScreen> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case 'Sign Out':
                  ref.read(authScreenViewModelProvider).signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Sign Out'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Weight>?>(
          stream: ref.read(weightScreenViewModelProvider).getWeights(),
          builder: (context, weights) {
            if (!weights.hasData) return const LinearProgressIndicator();
            return ListView.builder(
              itemCount: weights.data!.length,
              itemBuilder: (context, index) {
                final weight = weights.data![index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          _setWeights(weight: weight);
                        },
                        backgroundColor: Colors.blue,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          ref
                              .read(weightScreenViewModelProvider)
                              .deleteWeight(weight);
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        weight.weight.toString(),
                        style: const TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                          ref
                              .read(weightScreenViewModelProvider)
                              .formatDateTime(weight.timestamp as DateTime),
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400)),
                    ),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _setWeights();
        },
      ),
    );
  }

  _setWeights({Weight? weight}) {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(children: [
              Center(
                  child: TextField(
                textAlign: TextAlign.center,
                controller: TextEditingController()
                  ..text = weight?.weight.toString() ?? '',
                onChanged: (value) {
                  text = value;
                },
              )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  onPressed: () {
                    ref.read(weightScreenViewModelProvider).setWeight(Weight(
                        weight: double.parse(text),
                        timestamp: weight?.timestamp,
                        itemId: weight?.itemId));
                    Navigator.pop(context);
                  },
                  child: (weight?.itemId != null)
                      ? const Text("Update Weight")
                      : const Text("Add Weight"))
            ]));
  }
}
