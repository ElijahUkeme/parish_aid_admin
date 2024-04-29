class LoginState {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final bool showEmail;
  final bool showPassword;
  final bool showSignUpForm;
  final bool showLoadingBar;
  final bool showPreviewIcon;
  final bool isLoginState;

  LoginState(
      {this.email = "",
      this.password = "",
      this.firstName = "",
      this.lastName = "",
      this.showEmail = false,
      this.showPassword = false,
      this.showLoadingBar = false,
      this.showSignUpForm = false,
      this.showPreviewIcon = true,
      this.isLoginState = false});

  LoginState copyWith(
      {String? email,
      String? password,
      String? firstName,
      String? lastName,
      bool? showEmail,
      bool? showPassword,
      bool? showSignUpForm,
      bool? showLoadingBar,
      bool? showPreviewIcon,
      bool? isLoginState}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        showEmail: showEmail ?? this.showEmail,
        showPassword: showPassword ?? this.showPassword,
        showLoadingBar: showLoadingBar ?? this.showLoadingBar,
        showPreviewIcon: showPreviewIcon ?? this.showPreviewIcon,
        showSignUpForm: showSignUpForm ?? this.showSignUpForm,
        isLoginState: isLoginState ?? this.isLoginState);
  }
}
