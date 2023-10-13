import 'package:app/domain/models/rents.dart';
import 'package:app/presentation/logic/rents_bloc/rents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/vehicles.dart';

class DetailCars extends StatefulWidget {
  final Vehicle vehicle;

  const DetailCars({Key? key, required this.vehicle}) : super(key: key);

  @override
  _DetailCarsState createState() => _DetailCarsState();
}

class _DetailCarsState extends State<DetailCars> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black87,
          title: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white60,
              size: 30,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopMenuAndShowcase(
              vehicle: widget.vehicle,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                "Specifications",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/icons/ic_speedometer.png",
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: widget.vehicle.kilometrage
                                          .toString()),
                                  const TextSpan(
                                    text: ' km',
                                    style: TextStyle(
                                      color: Colors.white38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotatedBox(
                              quarterTurns: 1,
                              child: Image.asset(
                                "assets/icons/ic_cartopview.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${widget.vehicle.nb_places.toString()} places'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotatedBox(
                              quarterTurns: 1,
                              child: Image.asset(
                                "assets/icons/ic_transmission.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${widget.vehicle.transmission}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 24,
                            color: Colors.black54,
                          ),
                          Text(
                            widget.vehicle.center?.town?.inseeCode ?? "",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      const Icon(
                        Icons.home_filled,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.vehicle.center?.address}',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        bottomSheet: PriceAndBookNow(vehicle: widget.vehicle),
      ),
    );
  }
}

class PriceAndBookNow extends StatelessWidget {
  final Vehicle vehicle;
  final TextEditingController _addNbDaysController = TextEditingController();

  PriceAndBookNow({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(text: '\$${vehicle.amount_excluding}'),
                const TextSpan(
                    text: '/day', style: TextStyle(color: Colors.black38)),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 50,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 0, 10),
            child: TextField(
              onChanged: (value) {},
              controller: _addNbDaysController,
              decoration: const InputDecoration(
                  hintText: "5J"),
            ),
          ),
        ),
        BlocConsumer<RentsBloc, RentsState>(
          listener: (context, state) {
            if (state.status == RentsStatus.editSuccess) {
              debugPrint("rents : ${state.rents}");
              _showSnackBar(context, 'Location réservée', Colors.greenAccent);
              Navigator.of(context).pop();
            } else if (state.status == RentsStatus.error) {
              debugPrint(state.error);
              _showSnackBar(context, state.error, Colors.orangeAccent);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case RentsStatus.loading:
                return const CircularProgressIndicator();
              default:
                return SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => _onAddRent(context),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      "Book now",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                );
            }
          },
        ),
      ],
    );
  }

  void _onAddRent(BuildContext context) {
    var bloc = BlocProvider.of<RentsBloc>(context);
    if (_addNbDaysController.text != "") {
      final rent = Rent(
        id: '',
        nbDays: int.parse(_addNbDaysController.text),
        amountExcluding: vehicle.amount_excluding!,
        vehicleId: int.parse(vehicle.id),
        status: "RENTED",
      );
      bloc.add(AddRent(rent: rent));
    } else {
      _showSnackBar(
          context, 'Vous devez saisir le nombre de jour de location', Colors.redAccent);
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

class TopMenuAndShowcase extends StatelessWidget {
  final Vehicle vehicle;

  const TopMenuAndShowcase({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 70,
            right: 20,
            left: 20,
            bottom: 0,
            child: Image.asset(
              "assets/images/tesla_1.png",
              width: 300,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 18, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                spreadRadius: 0.5)
                          ],
                        ),
                        child: Image.network(
                          vehicle.model!.brand.logoUri,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.model!.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              vehicle.model!.releaseYear.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
