import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/apifiles/api.dart';
import 'package:malabis_app/data/providers/navigation_provider.dart';
import 'package:malabis_app/data/providers/orders_provider.dart';
import 'package:malabis_app/data/repository/authentication_repository.dart';
import 'package:malabis_app/data/repository/home_repository.dart';
import 'package:malabis_app/data/repository/navigation_provider.dart';
import 'package:malabis_app/data/repository/order_repository.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/navigation/navigation_cubit.dart';
import 'package:malabis_app/logic/order/orders_cubit.dart';
import 'package:malabis_app/logic/whishlist/whishlistcubit.dart';
import 'package:malabis_app/routes/custom_routes.dart';
import 'package:malabis_app/views/authentication/signup/welcome_screen.dart';
import 'package:malabis_app/views/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Dio dio = Dio();

  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;
  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => NavigationProvider()),
        RepositoryProvider(
          create: (context) =>
              NavigationRepository(context.read<NavigationProvider>()),
        ),
        RepositoryProvider(create: (_) => WordPressApi()),
        RepositoryProvider(
            create: (_) => AuthRepository(FirebaseAuth.instance)),
        RepositoryProvider(create: (_) => OrderProvider()),
        RepositoryProvider(
          create: (context) =>
              HomeRepository(api: context.read<WordPressApi>()),
        ),
        RepositoryProvider(
          create: (context) =>
              OrderRepository(context.read<OrderProvider>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => NavigationCubit()),
              BlocProvider<AuthCubit>(
                create: (context) =>
                    AuthCubit(context.read<AuthRepository>()),
              ),
              BlocProvider(create: (_) => WishlistCubit()),
              BlocProvider<HomeCubit>(
                create: (context) =>
                    HomeCubit(context.read<HomeRepository>())..loadProducts(),
              ),
              BlocProvider(create: (_) => CartCubit()),
              BlocProvider<OrderCubit>(
                create: (context) =>
                    OrderCubit(context.read<OrderRepository>()),
              ),
            ],
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Malabis App',
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    primarySwatch: Colors.blue,
                  ),
                  onGenerateRoute: CustomRoutes.allRoutes,
                  home: _buildHome(state),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildHome(AuthState state) {
    if (state is AuthLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (state is AuthAuthenticated) {
      return MainScaffold(); // 👈 Replaces BottomNavBar
    } else {
      return const WelcomeScreen();
    }
  }
}
