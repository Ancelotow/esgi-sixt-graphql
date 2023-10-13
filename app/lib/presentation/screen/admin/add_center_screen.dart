import 'package:app/domain/models/centers.dart';
import 'package:app/presentation/logic/centers_bloc/centers_bloc.dart';
import 'package:app/presentation/logic/town_bloc/towns_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/town.dart';

class AddCenterScreen extends StatelessWidget {
  static const String routeName = '/AddCenterScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  Town? townSelected;
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  AddCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TownsBloc>(context).add(GetTownsEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un centre',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: const Color(0xFFf9ffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nom du centre",
              ),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Adresse",
              ),
            ),
            BlocBuilder<TownsBloc, TownsState>(
              builder: (context, state) {
                if (state.status == TownStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == TownStatus.success) {
                  return DropdownButton<Town>(
                    value: state.towns[0],
                    onChanged: (Town? newValue) => townSelected = newValue,
                    items: state.towns.map<DropdownMenuItem<Town>>((
                        Town value) {
                      return DropdownMenuItem<Town>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const Spacer(),
            BlocConsumer<CentersBloc, CentersState>(
              listener: (context, state) {
                if(state.status == CentersStatus.successAdd) {
                  Navigator.of(context).pop();
                } else if(state.status == CentersStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if(state.status == CentersStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () => _addCenter(context),
                  child: const Text('Ajouter'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addCenter(BuildContext context) {
    if(nameController.text.isNotEmpty && addressController.text.isNotEmpty && townSelected != null) {
      final center = CenterVehicle(
        name: nameController.text,
        address: addressController.text,
        town: townSelected!,
        id: '',
      );
      BlocProvider.of<CentersBloc>(context).add(AddCenter(center));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
        ),
      );
    }
  }
}
