import 'package:app/data_sources/api_users_data_source.dart';
import 'package:app/data_sources/api_vehicles_data_source.dart';
import 'package:app/models/users.dart';
import 'package:app/repository/vehicles_repository.dart';
import 'package:app/screen/home/vehicle_screen.dart';
import 'package:app/signIn_signUp/connexion_screen.dart';
import 'package:app/signIn_signUp/home_screen.dart';
import 'package:app/signIn_signUp/register_screen.dart';
import 'package:app/users_bloc/users_bloc.dart';
import 'package:app/repository/users_repository.dart';
import 'package:app/vehicles_bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  await initHiveForFlutter();
  await Hive.openBox('SixtGi');

  runApp(MyApp());
}

final HttpLink httpLink = HttpLink(
  '${dotenv.env["API_BASE_URI"]}/graphql',
);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  ),
);

class MyApp extends StatelessWidget {
  final User? user;

  MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UsersRepository(
        userDataSource: ApiUsersDataSource(),
      ),
      child: BlocProvider<UsersBloc>(
        create: (context) => UsersBloc(
          RepositoryProvider.of<UsersRepository>(context),
        ),
        child: BlocProvider<VehiclesBloc>(
          create: (context) => VehiclesBloc(
            repository: VehiclesRepository(
              vehiclesDataSource: ApiVehiclesDataSource(),
            ),
          ),
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
      ),
    );
  }
}
