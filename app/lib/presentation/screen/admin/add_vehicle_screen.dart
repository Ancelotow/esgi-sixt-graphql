import 'package:app/domain/models/brand_model.dart';
import 'package:app/domain/models/centers.dart';
import 'package:app/domain/models/color.dart';
import 'package:app/presentation/logic/centers_bloc/centers_bloc.dart';
import 'package:app/presentation/logic/models_bloc/models_bloc.dart';
import 'package:app/presentation/logic/town_bloc/towns_bloc.dart';
import 'package:app/presentation/logic/vehicles_bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/vehicles.dart';
import '../../logic/colors_bloc/colors_bloc.dart';

class AddVehicleScreen extends StatelessWidget {
  static const String routeName = '/AddVehicleScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  BrandModel? modelSelected;
  VehicleColor? colorSelected;
  CenterVehicle? centerSelected;
  final numberPlate = TextEditingController();
  final nbPlace = TextEditingController();
  final amountExcludingController = TextEditingController();
  final maxChargeController = TextEditingController();
  final maxSpeedAllowedController = TextEditingController();
  final imageUriController = TextEditingController();

  AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CentersBloc>(context).add(GetAllCenters());
    BlocProvider.of<ModelsBloc>(context).add(GetModelsEvent());
    BlocProvider.of<ColorsBloc>(context).add(GetColorsEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un véhicule',
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
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: numberPlate,
                    decoration: const InputDecoration(
                      labelText: "Plaque d'immatriculation",
                    ),
                  ),
                  TextField(
                    controller: amountExcludingController,
                    decoration: const InputDecoration(
                      labelText: "Montant HT",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: nbPlace,
                    decoration: const InputDecoration(
                      labelText: "Nombre de places",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: maxChargeController,
                    decoration: const InputDecoration(
                      labelText: "Charge max.",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: maxSpeedAllowedController,
                    decoration: const InputDecoration(
                      labelText: "Vitesse max.",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: imageUriController,
                    decoration: const InputDecoration(
                      labelText: "Image",
                    ),
                  ),
                  BlocBuilder<ModelsBloc, ModelsState>(
                    builder: (context, state) {
                      if (state.status == ModelStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == ModelStatus.success) {
                        return DropdownButton<BrandModel>(
                          value: modelSelected,
                          onChanged: (BrandModel? newValue) =>
                              modelSelected = newValue,
                          items: state.models
                              .map<DropdownMenuItem<BrandModel>>((BrandModel value) {
                            return DropdownMenuItem<BrandModel>(
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
                  BlocBuilder<ColorsBloc, ColorsState>(
                    builder: (context, state) {
                      if (state.status == ColorsStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == ColorsStatus.success) {
                        return DropdownButton<VehicleColor>(
                          value: colorSelected,
                          onChanged: (VehicleColor? newValue) =>
                              colorSelected = newValue,
                          items: state.colors.map<DropdownMenuItem<VehicleColor>>(
                              (VehicleColor value) {
                            return DropdownMenuItem<VehicleColor>(
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
                  BlocBuilder<CentersBloc, CentersState>(
                    builder: (context, state) {
                      if (state.status == CentersStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == CentersStatus.success) {
                        return DropdownButton<CenterVehicle>(
                          value: centerSelected,
                          onChanged: (CenterVehicle? newValue) =>
                              centerSelected = newValue,
                          items: state.centers.map<DropdownMenuItem<CenterVehicle>>(
                              (CenterVehicle value) {
                            return DropdownMenuItem<CenterVehicle>(
                              value: value,
                              child: Text(value.name ?? ""),
                            );
                          }).toList(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  BlocConsumer<VehiclesBloc, VehiclesState>(
                    listener: (context, state) {
                      if (state.status == VehiclesStatus.editSuccess) {
                        Navigator.of(context).pop();
                      } else if (state.status == VehiclesStatus.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.status == VehiclesStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () => _addVehicle(context),
                        child: const Text('Ajouter'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addVehicle(BuildContext context) {
    if (numberPlate.text.isNotEmpty &&
        amountExcludingController.text.isNotEmpty &&
        nbPlace.text.isNotEmpty &&
        maxChargeController.text.isNotEmpty &&
        maxSpeedAllowedController.text.isNotEmpty &&
        imageUriController.text.isNotEmpty &&
        centerSelected != null &&
        colorSelected != null &&
        modelSelected != null) {
      final vehicle = Vehicle(
        number_plate: numberPlate.text,
        amount_excluding: int.parse(amountExcludingController.text),
        nb_places: int.parse(nbPlace.text),
        max_charge: int.parse(maxChargeController.text),
        max_speed_allowed: int.parse(maxSpeedAllowedController.text),
        imageUri: imageUriController.text,
        center: centerSelected,
        color: colorSelected,
        model: modelSelected,
        id: '',
      );
      BlocProvider.of<VehiclesBloc>(context).add(AddVehicle(vehicle: vehicle));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
