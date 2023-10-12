import 'package:app/data_sources/api/api_brand_data_source.dart';
import 'package:app/data_sources/api/api_rents_data_source.dart';
import 'package:app/domain/repository/rents_repository.dart';
import 'package:app/presentation/logic/brands_bloc/brands_bloc.dart';
import 'package:app/presentation/logic/rents_bloc/rents_bloc.dart';
import 'package:app/presentation/logic/users_bloc/users_bloc.dart';
import 'package:app/presentation/logic/vehicles_bloc/vehicles_bloc.dart';
import 'package:app/presentation/screen/home/vehicle_screen.dart';
import 'package:app/presentation/signIn_signUp/connexion_screen.dart';
import 'package:app/presentation/signIn_signUp/home_screen.dart';
import 'package:app/presentation/signIn_signUp/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'data_sources/api/api_users_data_source.dart';
import 'data_sources/api/api_vehicles_data_source.dart';
import 'domain/models/session.dart';
import 'domain/models/users.dart';
import 'domain/repository/brand_repository.dart';
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
    final client = _initGraphQlClient();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UsersRepository>(
          create: (context) => UsersRepository(
            userDataSource: ApiUsersDataSource(client),
          ),
        ),
        RepositoryProvider<VehiclesRepository>(
          create: (context) => VehiclesRepository(
            vehiclesDataSource: ApiVehiclesDataSource(client),
          ),
        ),
        RepositoryProvider<RentsRepository>(
          create: (context) => RentsRepository(
            rentDataSource: ApiRentsDataSource(client),
          ),
        ),
        RepositoryProvider<BrandRepository>(
          create: (context) => BrandRepository(
            brandDataSource: ApiBrandDataSource(client),
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
        ],
        child: GraphQLProvider(
          client: client,
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
              VehicleScreen.routeName: (context) => const VehicleScreen(),
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

  ValueNotifier<GraphQLClient> _initGraphQlClient() {
    final options = BaseOptions(
      baseUrl: dotenv.env['API_BASE_URI'] ?? "",
    );
    final Dio dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer ${Session.instance().token}';
        handler.next(options);
      },
    ));
    final link = Link.from([
      DioLink("/graphql", client: Dio(options)),
    ]);
    return ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(),
      ),
    );
  }
}
