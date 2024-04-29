abstract class LoginEvents {
  LoginEvents();
}

class EmailEvent extends LoginEvents {
  final String email;
  EmailEvent(this.email);
}

class PasswordEvent extends LoginEvents {
  final String password;
  PasswordEvent(this.password);
}

class ValidateEvent extends LoginEvents {
  ValidateEvent();
}

class FirstNameEvent extends LoginEvents {
  final String firstName;
  FirstNameEvent(this.firstName);
}

class LastNameEvent extends LoginEvents {
  final String lastName;
  LastNameEvent(this.lastName);
}

class IconEvent extends LoginEvents {
  IconEvent();
}

class LoadingBarEvent extends LoginEvents {
  final bool isLoading;
  LoadingBarEvent(this.isLoading);
}

class ActionEvent extends LoginEvents {
  final bool isLogin;
  ActionEvent(this.isLogin);
}
