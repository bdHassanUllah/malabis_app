import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/DTO/auth_dto/customer_service_dto.dart';
import 'package:malabis_app/DTO/auth_dto/dio_client_helper.dart';
import 'package:malabis_app/DTO/model/auth_dto_model.dart';
import 'package:malabis_app/data/repository/authentication_repository.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  // Check if the user is already authenticated
  Future<void> checkUserAuthentication() async {
    emit(AuthLoading());
    try {
      final User? user = await authRepository.getCurrentUser();
      if (user != null) {
        final int userId = _generateUserId(user);
        emit(AuthAuthenticated(userId, user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError("Error checking user authentication: ${e.toString()}"));
    }
  }

  // Sign-in using Google
  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final User? user = await authRepository.signInWithGoogle();
      if (user != null) {
        final int customerId = _generateUserId(user);

        // ✅ Send data to WooCommerce
        await _createWooCommerceCustomer(user);

        emit(AuthAuthenticated(customerId, user));
      } else {
        emit(AuthError("Google sign-in failed"));
      }
    } catch (e) {
      emit(AuthError("Google sign-in error: ${e.toString()}"));
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Generate int userId from Firebase UID
  int _generateUserId(User user) {
    return user.uid.hashCode;
  }

  int? getUserId() {
    if (state is AuthAuthenticated) {
      return (state as AuthAuthenticated).userId;
    }
    return null;
  }

  // ✅ WooCommerce Customer Creation
  Future<void> _createWooCommerceCustomer(User user) async {
  try {
    final dio = getWooCommerceDioClient(
      baseUrl: "https://malabis.pk", 
      consumerKey: 'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59', 
      consumerSecret: 'cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4',
    );
    
    final customerDto = CreateCustomerRequestDto(
      email: user.email ?? '',
      firstName: user.displayName?.split(' ').first ?? 'First',
      lastName: user.displayName?.split(' ').last ?? 'Last',
      username: user.email?.split('@').first ?? 'user'
    );
    
    final customerService = CustomerService(dio: dio);
    final response = await customerService.createCustomer(customerDto);
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      final customerId = response.data['id'] as int; // Ensure 'id' is int
      print('Customer created: $customerId');
    } else {
      print('Unexpected response: ${response.data}');
    }
  } on DioException catch (e) {
    if (e.response?.data is String && (e.response?.data as String).contains('expired')) {
      print('Domain expired or invalid!');
    } else {
      print('WooCommerce error: ${e.message}');
    }
  } catch (e) {
    print('Unexpected error: $e');
  }
}
}