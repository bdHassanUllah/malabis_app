import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/data/repository/home_repository.dart';
import 'package:malabis_app/data/repository/order_repository.dart';
import 'package:malabis_app/firebase_options.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/initcubit.dart';
import 'package:malabis_app/logic/order/orders_cubit.dart';
import 'package:malabis_app/routes/custom_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter(); // Required for graphql_flutter cache

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const String username = 'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59';
  const String password = 'cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4';

  final String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  final HttpLink httpLink = HttpLink(
    'https://malabis.pk/graphql',
    defaultHeaders: {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    },
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  final homeRepository = HomeRepository();

  runApp(MyApp(
    graphQLClient: client,
    homeRepository: homeRepository,
  ));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> graphQLClient;
  final HomeRepository homeRepository;

  const MyApp({
    super.key,
    required this.graphQLClient,
    required this.homeRepository,
  });

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLClient,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => InitCubit()),
          BlocProvider(create: (_) => AuthenticationCubit()),
          BlocProvider(create: (c) => HomeCubit()),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => OrdersCubit(OrdersRepository())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Malabis App',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: CustomRoutes.allRoutes,
          initialRoute: '/',
        ),
      ),
    );
  }
}
