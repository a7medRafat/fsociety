
abstract class AppLoginStates {}
class AppLoginInitialState extends AppLoginStates{}
class AppChangeVisibilityState extends AppLoginStates{}

class AppLoginLoadingState extends AppLoginStates{}
class AppLoginSuccessState extends AppLoginStates{
  final String uid;

  AppLoginSuccessState(this.uid);
}
class AppLoginErrorState extends AppLoginStates{
  final  error;
  AppLoginErrorState(this.error);
}

class googleSigningSuccessState extends AppLoginStates{}
class googleSigningErrorState extends AppLoginStates{}