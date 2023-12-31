import 'package:app/data_sources/api/api_brand_data_source.dart';
import 'package:app/data_sources/api/api_center_data_source.dart';
import 'package:app/data_sources/api/api_rents_data_source.dart';
import 'package:app/data_sources/api/api_town_data_source.dart';
import 'package:app/domain/repository/brand_model_repository.dart';
import 'package:app/domain/repository/center_repository.dart';
import 'package:app/domain/repository/rents_repository.dart';
import 'package:app/domain/repository/town_repository.dart';
import 'package:app/presentation/logic/brands_bloc/brands_bloc.dart';
import 'package:app/presentation/logic/centers_bloc/centers_bloc.dart';
import 'package:app/presentation/logic/colors_bloc/colors_bloc.dart';
import 'package:app/presentation/logic/models_bloc/models_bloc.dart';
import 'package:app/presentation/logic/rents_bloc/rents_bloc.dart';
import 'package:app/presentation/logic/town_bloc/towns_bloc.dart';
import 'package:app/presentation/logic/users_bloc/users_bloc.dart';
import 'package:app/presentation/logic/vehicles_bloc/vehicles_bloc.dart';
import 'package:app/presentation/screen/admin/add_center_screen.dart';
import 'package:app/presentation/screen/admin/add_vehicle_screen.dart';
import 'package:app/presentation/screen/home/vehicle_screen.dart';
import 'package:app/presentation/screen/navigation/navigation_screen.dart';
import 'package:app/presentation/signIn_signUp/connexion_screen.dart';
import 'package:app/presentation/signIn_signUp/home_screen.dart';
import 'package:app/presentation/signIn_signUp/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'data_sources/api/api_brand_model_data_source.dart';
import 'data_sources/api/api_color_data_source.dart';
import 'data_sources/api/api_users_data_source.dart';
import 'data_sources/api/api_vehicles_data_source.dart';
import 'domain/models/session.dart';
import 'domain/models/users.dart';
import 'domain/repository/brand_repository.dart';
import 'domain/repository/color_repository.dart';
import 'domain/repository/users_repository.dart';
import 'domain/repository/vehicles_repository.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  await initHiveForFlutter();
  await Hive.openBox('SixtGi');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User? user;

  MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UsersRepository>(
          create: (context) => UsersRepository(
            userDataSource: ApiUsersDataSource(),
          ),
        ),
        RepositoryProvider<VehiclesRepository>(
          create: (context) => VehiclesRepository(
            vehiclesDataSource: ApiVehiclesDataSource(),
          ),
        ),
        RepositoryProvider<RentsRepository>(
          create: (context) => RentsRepository(
            rentDataSource: ApiRentsDataSource(),
          ),
        ),
        RepositoryProvider<BrandRepository>(
          create: (context) => BrandRepository(
            brandDataSource: ApiBrandDataSource(),
          ),
        ),
        RepositoryProvider<CenterRepository>(
          create: (context) => CenterRepository(
            centerDataSource: ApiCenterDataSource(),
          ),
        ),
        RepositoryProvider<TownRepository>(
          create: (context) => TownRepository(
            townDataSource: ApiTownDataSource(),
          ),
        ),
        RepositoryProvider<ColorRepository>(
          create: (context) => ColorRepository(
            colorDataSource: ApiColorDataSource(),
          ),
        ),
        RepositoryProvider<BrandModelRepository>(
          create: (context) => BrandModelRepository(
            brandModelDataSource: ApiBrandModelDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UsersBloc>(
            create: (context) => UsersBloc(
              RepositoryProvider.of<UsersRepository>(context),
            ),
          ),
          BlocProvider<VehiclesBloc>(
            create: (context) => VehiclesBloc(
              repository: RepositoryProvider.of<VehiclesRepository>(context),
            ),
          ),
          BlocProvider<RentsBloc>(
            create: (context) => RentsBloc(
              RepositoryProvider.of<RentsRepository>(context),
            ),
          ),
          BlocProvider<BrandsBloc>(
            create: (context) => BrandsBloc(
              repository: RepositoryProvider.of<BrandRepository>(context),
            ),
          ),
          BlocProvider<CentersBloc>(
            create: (context) => CentersBloc(
              repository: RepositoryProvider.of<CenterRepository>(context),
            ),
          ),
          BlocProvider<TownsBloc>(
            create: (context) => TownsBloc(
              repository: RepositoryProvider.of<TownRepository>(context),
            ),
          ),
          BlocProvider<ColorsBloc>(
            create: (context) => ColorsBloc(
              repository: RepositoryProvider.of<ColorRepository>(context),
            ),
          ),
          BlocProvider<ModelsBloc>(
            create: (context) => ModelsBloc(
              repository: RepositoryProvider.of<BrandModelRepository>(context),
            ),
          ),
        ],
        child: GraphQLProvider(
          client: Session.instance().getGraphQLClient(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                bodySmall: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                color: Color(0xFFf9ffff), //<-- SEE HERE
              ),
            ),
            routes: {
              '/': (context) => const HomeScreen(),
              ConnexionScreen.routeName: (context) => ConnexionScreen(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              NavigatorScreen.routeName: (context) => const NavigatorScreen(),
              VehicleScreen.routeName: (context) => VehicleScreen(),
              AddCenterScreen.routeName: (context) => AddCenterScreen(),
              AddVehicleScreen.routeName: (context) => AddVehicleScreen(),
            },
            onGenerateRoute: (settings) {
              Widget content = const SizedBox.shrink();
              switch (settings.name) {
                /*
                          case ProfilScreen.routeName:
                    final arguments = settings.arguments;
                    if (arguments is User) {
                      content = ProfilScreen(user: arguments);
                    }
                    break;
                             */
              }
              return MaterialPageRoute(
                builder: (context) {
                  return content;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
