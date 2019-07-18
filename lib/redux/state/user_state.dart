import 'package:fusewallet/modals/user.dart';
import 'package:meta/meta.dart';

@immutable
class UserState {
  final bool isLoading;
  final bool has3boxAccount;
  final bool loginError;
  final bool isUserLogged;
  final String verificationCode;
  final User user;

  UserState(
      {@required this.isLoading,
      @required this.loginError,
      @required this.isUserLogged,
      @required this.verificationCode,
      @required this.user,
      @required this.has3boxAccount});

  factory UserState.initial() {
    return new UserState(
        isLoading: false,
        loginError: false,
        user: null,
        has3boxAccount: false);
  }

  UserState copyWith(
      {bool isLoading,
      bool loginError,
      bool isUserLogged,
      User user,
      String verificationCode,
      bool has3boxAccount}) {
    return new UserState(
        isLoading: isLoading ?? this.isLoading,
        loginError: loginError ?? this.loginError,
        isUserLogged: isUserLogged ?? this.isUserLogged,
        user: user ?? this.user,
        verificationCode: verificationCode ?? this.verificationCode,
        has3boxAccount: has3boxAccount ?? this.has3boxAccount);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          loginError == other.loginError &&
          user == other.user;

  @override
  int get hashCode => isLoading.hashCode ^ user.hashCode;

  static UserState fromJson(dynamic json) {
    return UserState(
      user: User.fromJson(json["user"]),
      isLoading: false,
      isUserLogged: false,
      loginError: false,
      verificationCode: "",
      has3boxAccount: json["has3boxAccount"]);
  }

  dynamic toJson() => {'user': user, 'isUserLogged': isUserLogged, 'has3boxAccount': has3boxAccount};
}
