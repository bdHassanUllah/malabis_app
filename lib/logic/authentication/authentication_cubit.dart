// authentication_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/repository/authentication_repository.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState());

  String get getuserID {
    // Replace with the actual logic to retrieve the user ID
    return "user-id-placeholder";
  }

  final GoogleSignInRepository _googleSignInRepository = GoogleSignInRepository();

  Future<void> signInWithGoogle() async {
  emit(state.copyWith(isLoading: true, error: null)); // Fixed copyWith()

  try {
    final userCredential = await _googleSignInRepository.signInWithGoogle();

    if (userCredential != null) {
      emit(state.copyWith(
        email: userCredential.user?.email,
        name: userCredential.user?.displayName,
        loggedIn: true,
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        error: 'Sign in was cancelled',
      ));
    }
  } catch (e) {
    emit(state.copyWith(
      isLoading: false,
      error: 'Google Sign-In failed: $e',
    ));
  }
}

  Future<void> signOut() async {
    try {
      await _googleSignInRepository.signOut();
      emit(AuthenticationState()); // Reset to initial state
    } catch (e) {
      emit(state.copyWith(error: 'Sign out failed: $e'));
    }
  }
}