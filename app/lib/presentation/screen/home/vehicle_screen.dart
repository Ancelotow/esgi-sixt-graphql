import 'package:app/presentation/screen/home/widgets/brand_list.dart';
import 'package:app/presentation/screen/home/widgets/cars_item.dart';
import 'package:app/presentation/screen/home/widgets/search_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../logic/vehicles_bloc/vehicles_bloc.dart';

class VehicleScreen extends StatefulWidget {
  static const String routeName = '/VehicleScreen';
  final TextEditingController _maxKmController = TextEditingController();
  final TextEditingController _minPlaceController = TextEditingController();

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<VehiclesBloc>(context).add(GetAllVehicles());
    return Scaffold(
      body: Column(
        children: [
          SearchButton(),
          BrandList(),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 23),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Available cars",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.sort),
                          onPressed: () => _displayAlertDialogToFilter(context),
                        )
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              BlocBuilder<VehiclesBloc, VehiclesState>(
                                builder: (context, state) {
                                  switch (state.status) {
                                    case VehiclesStatus.loading:
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    case VehiclesStatus.error:
                                      return Center(
                                        child: Text(
                                          state.error,
                                        ),
                                      );
                                    case VehiclesStatus.success:
                                    default:
                                      if (state.vehicles.isEmpty) {
                                        return const Center(
                                          child: Text(
                                              "Aucune Voiture, Attendez les prochaines locations !"),
                                        );
                                      }
                                      return ListView.builder(
                                        itemCount: state.vehicles.length,
                                        itemBuilder: (context, index) {
                                          final vehicle = state.vehicles[index];
                                          return CarItem(
                                            vehicle: vehicle,
                                          );
                                        },
                                      );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _displayAlertDialogToFilter(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<VehiclesBloc, VehiclesState>(
          listener: (context, state) {
            if (state.status == VehiclesStatus.editSuccess) {
              _showSnackBar(context, 'Filtre ajouté', Colors.greenAccent);
              widget._minPlaceController.text = "";
              widget._maxKmController.text = "";
              //NavigatorScreen.navigateTo(context);
            } else if (state.status == VehiclesStatus.error) {
              debugPrint(state.error);
              _showSnackBar(context, state.error, Colors.orangeAccent);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case VehiclesStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return AlertDialog(
                  title: const Text('Ajouter des filtres'),
                  content: Column(
                    children: [
                      TextField(
                        onChanged: (value) {},
                        controller: widget._maxKmController,
                        decoration: const InputDecoration(
                            hintText: "Maximum kilometrage"),
                      ),
                      TextField(
                        onChanged: (value) {},
                        controller: widget._minPlaceController,
                        decoration:
                            const InputDecoration(hintText: "Minimum places"),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: const Text('Filtrer'),
                      onPressed: () => _filter(context),
                    ),
                  ],
                );
            }
          },
        );
      },
    );
  }

  void _filter(BuildContext context) {
    if (widget._maxKmController.text != "" &&
        widget._minPlaceController.text != "") {
      BlocProvider.of<VehiclesBloc>(context).add(
        GetFilterVehicles(
            maxKm: widget._maxKmController.text,
            minPlace: widget._minPlaceController.text),
      );
      Navigator.of(context).pop();
    } else {
      _showSnackBar(
          context, 'Vous devez remplir les 2 champs', Colors.redAccent);
    }
  }

  void _showSnackBar(BuildContext context, String text, Color background) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: background,
      ),
    );
  }
}
