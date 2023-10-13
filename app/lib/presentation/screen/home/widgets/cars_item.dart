import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/models/vehicles.dart';
import '../../detail_cars/detail_cars.dart';

class CarItem extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback? onTap;

  const CarItem({
    Key? key,
    required this.vehicle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
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
                        blurRadius: 15)
                  ]),
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
                          vehicle.brand!.name,
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          vehicle.center!.town!.inseeCode,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(text: '\$${vehicle.amount_excluding}'),
                            const TextSpan(
                                text: '/day',
                                style: TextStyle(color: Colors.black38)),
                          ],
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailCars(
                                      vehicle: vehicle,
                                    )));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                          ),
                          child: Text(
                            "Details",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )
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
