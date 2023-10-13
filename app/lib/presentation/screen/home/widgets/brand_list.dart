import 'package:app/presentation/logic/vehicles_bloc/vehicles_bloc.dart';
import 'package:app/presentation/screen/navigation/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/models/brand.dart';
import '../../../logic/brands_bloc/brands_bloc.dart';
import 'brand_item.dart';

class BrandList extends StatefulWidget {
  const BrandList({
    Key? key,
  }) : super(key: key);

  @override
  _BrandListState createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  List<Brand> brands = [];
  int _brandCategoryIndex = 0;

  void setBrandIndex(int currentIndex, String brand) {
    setState(() {
      _brandCategoryIndex = currentIndex;
    });
    if (brand == "all") {
      BlocProvider.of<VehiclesBloc>(context).add(GetAllVehicles());
      NavigatorScreen.navigateTo(context);
    } else {
      BlocProvider.of<VehiclesBloc>(context).add(
        GetBrandVehicles(brand: brand),
      );
      NavigatorScreen.navigateTo(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BrandsBloc>(context).add(GetAllBrands());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            "Brands",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: BlocBuilder<BrandsBloc, BrandsState>(
            builder: (context, state) {
              if (state.status == BrandsStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status == BrandsStatus.success) {
                brands = [Brand(id: 0, name: "All", logoUri: "")];
                brands.addAll(state.brands);
                return _body(context);
              } else if (state.status == BrandsStatus.error) {
                return Center(
                  child: Text(state.error),
                );
              }
              return _body(context);
            },
          ),
        )
      ],
    );
  }

  Widget _body(BuildContext context) {
    return ListView.builder(
      itemCount: brands.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () => setBrandIndex(index, "All"),
            child: BrandItem(
              brand: brands[index],
              index: 0,
              isSelected: (_brandCategoryIndex == index) ? true : false,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => setBrandIndex(index, brands[index].name),
            child: BrandItem(
              brand: brands[index],
              index: index,
              isSelected: (_brandCategoryIndex == index) ? true : false,
            ),
          );
        }
      },
    );
  }
}
