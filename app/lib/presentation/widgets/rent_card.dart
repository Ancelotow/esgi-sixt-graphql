import 'package:app/domain/models/centers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/models/rents.dart';

class RentCard extends StatelessWidget {
  final Rent rent;
  final Function(Rent)? onTap;

  const RentCard({
    super.key,
    required this.rent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 20, top: 20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0.5,
                    blurRadius: 15,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          rent.vehicle?.model?.name ?? "Unknown",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${rent.amountExcluding}€ (${rent.nbDays} days)",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 15,
            child: Image.asset(
              //vehicle.imageUri
              "assets/images/tesla_1.png",
              width: 150,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
