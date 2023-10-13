import 'package:app/domain/models/centers.dart';
import 'package:app/presentation/logic/centers_bloc/centers_bloc.dart';
import 'package:app/presentation/logic/vehicles_bloc/vehicles_bloc.dart';
import 'package:app/presentation/screen/admin/add_center_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/vehicles.dart';
import '../../widgets/center_card.dart';
import '../home/widgets/cars_item.dart';

class AdminScreen extends StatelessWidget {
  List<CenterVehicle> centers = [];
  List<Vehicle> vehicles = [];

  AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CentersBloc>(context).add(GetAllCenters());
    BlocProvider.of<VehiclesBloc>(context).add(GetAllVehicles());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Centers",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => AddCenterScreen.navigateTo(context),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
         Expanded(
           child: BlocBuilder<CentersBloc, CentersState>(
              builder: (context, state) {
                if (state.status == CentersStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == CentersStatus.success) {
                  centers = state.centers;
                  return _bodyCenters(context);
                } else if (state.status == CentersStatus.error) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return _bodyCenters(context);
              },
            ),
         ),
        Container(
          height: 2,
          color: Colors.black12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Vehicles",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<VehiclesBloc, VehiclesState>(
            builder: (context, state) {
              if (state.status == VehiclesStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status == VehiclesStatus.success) {
                vehicles = state.vehicles;
                return _bodyVehicles(context);
              } else if (state.status == VehiclesStatus.error) {
                return Center(
                  child: Text(state.error),
                );
              }
              return _bodyVehicles(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _bodyCenters(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: centers.length,
        itemBuilder: (context, index) {
          return CenterCard(
            center: centers[index],
            onTap: (center) {
              print(center);
            },
          );
        },
      ),
    );
  }

  Widget _bodyVehicles(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          return CarItem(
            vehicle: vehicles[index],
          );
        },
      ),
    );
  }
}
