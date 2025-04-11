// authentication_state.dart
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthenticationState {
  final String? phoneNum;
  final String? otp;
  final QueryResult? numberResult;
  final QueryResult? otpResult;
  final String? otpError;
  final String? email;
  final String? name;
  final int? userId;
  final bool loggedIn;
  final bool isLoading;
  final String? error;
  final QueryResult? faqRes;
  final String? faqStatus;

  const AuthenticationState({
    this.phoneNum,
    this.otp,
    this.numberResult,
    this.otpResult,
    this.otpError,
    this.email,
    this.name,
    this.userId,
    this.loggedIn = false,
    this.isLoading = false,
    this.error,
    this.faqRes,
    this.faqStatus,
  });

  AuthenticationState copyWith({
    String? phoneNum,
    String? otp,
    QueryResult? numberResult,
    QueryResult? otpResult,
    String? otpError,
    String? email,
    String? name,
    int? userId,
    bool? loggedIn,
    bool? isLoading,
    String? error,
    QueryResult? faqRes,
    String? faqStatus,
  }) {
    return AuthenticationState(
      phoneNum: phoneNum ?? this.phoneNum,
      otp: otp ?? this.otp,
      numberResult: numberResult ?? this.numberResult,
      otpResult: otpResult ?? this.otpResult,
      otpError: otpError ?? this.otpError,
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      loggedIn: loggedIn ?? this.loggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      faqRes: faqRes ?? this.faqRes,
      faqStatus: faqStatus ?? this.faqStatus,
    );
  }
}