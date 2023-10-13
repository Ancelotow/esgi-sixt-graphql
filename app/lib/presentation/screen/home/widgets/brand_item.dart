import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/models/brand.dart';

class BrandItem extends StatelessWidget {
  final Brand brand;
  final int index;
  final bool isSelected;

  const BrandItem({
    Key? key,
    required this.brand,
    required this.index,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (index == 0)
          ? const EdgeInsets.fromLTRB(20, 12, 10, 12)
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: (index == 0)
          ? const EdgeInsets.symmetric(vertical: 20, horizontal: 25)
          : const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (isSelected)
            ? Colors.blue
            : (index == 0)
                ? Colors.black12
                : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: (index == 0)
          ? Center(
              child: Text(
                "All",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Image.network(
              brand.logoUri,
              width: 30,
              height: 30,
            ),
    );
  }
}
