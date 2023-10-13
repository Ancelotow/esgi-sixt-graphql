import 'package:app/presentation/logic/rents_bloc/rents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/models/session.dart';
import '../../widgets/rent_card.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RentsBloc>(context).add(GetAllRents());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "My profile",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Prénom",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Nom de famille",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Email",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Session.instance().user?.firstname ?? "",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      Session.instance().user?.lastname ?? "",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      Session.instance().user?.email ?? "",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          "Rents",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        BlocBuilder<RentsBloc, RentsState>(
          builder: (context, state) {
            switch (state.status) {
              case RentsStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RentsStatus.error:
                return Center(
                  child: Text(
                    state.error,
                  ),
                );
              case RentsStatus.success:
              default:
                if (state.rents.isEmpty) {
                  return const Center(
                    child: Text("Aucune location"),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.rents.length,
                    itemBuilder: (context, index) {
                      final rent = state.rents[index];
                      return RentCard(
                        rent: rent,
                      );
                    },
                  ),
                );
            }
          },
        )
      ],
    );
  }
}
