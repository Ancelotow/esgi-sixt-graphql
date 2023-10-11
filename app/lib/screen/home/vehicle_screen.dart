import 'package:app/data_sources/api_vehicles_data_source.dart';
import 'package:app/models/vehicles.dart';
import 'package:app/repository/vehicles_repository.dart';
import 'package:app/screen/home/widgets/brand_list.dart';
import 'package:app/screen/home/widgets/cars_item.dart';
import 'package:app/screen/home/widgets/search_button.dart';
import 'package:app/vehicles_bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleScreen extends StatefulWidget {
  static const String routeName = '/VehicleScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  int _selectedPageIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => VehiclesRepository(
        vehiclesDataSource: ApiVehiclesDataSource(),
      ),
      child: BlocProvider(
        create: (context) => VehiclesBloc(
          repository: RepositoryProvider.of<VehiclesRepository>(context),
        )..add(GetAllVehicles()),
        child: SafeArea(
          child: Column(
            children: [
              SearchButton(),
              BrandList(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 23),
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
                            onPressed: () {
                              print("filter cars");
                            },
                            icon: Icon(Icons.sort),
                          )
                        ],
                      ),
                      Builder(
                        builder: (context) {
                          return Scaffold(
                            body: Stack(
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
                                        return ListView.builder(
                                          itemCount: state.vehicles.length,
                                          itemBuilder: (context, index) {
                                            final vehicle = state.vehicles[index];
                                            return CarItem(
                                              vehicle: vehicle,
                                              onTap: () =>
                                                  _onVehicleTap(context, vehicle),
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
            ],
          ),
        ),
      ),
    );
  }
}

void _onVehicleTap(BuildContext context, Vehicle vehicle) {
  //TODO
}
