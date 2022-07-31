import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/cubit/App%20cubit/AppCubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'LoginStates.dart';

class AppLoginCubit extends Cubit <AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  bool IsVisible = true;
  IconData SUffix = Icons.visibility;

  void ChangeVisibility(){
    IsVisible = !IsVisible;
    emit(AppChangeVisibilityState());
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void google(){
    signInWithGoogle().then((value) {
      print(value.user!.displayName!);
      emit(googleSigningSuccessState());
    }).catchError((error){
      print('error in ========>${error.toString()}');
      emit(googleSigningErrorState());
    });
  }

  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }){
    emit(AppLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      AppCubit.get(context).getUserData();
      emit(AppLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(AppLoginErrorState(error.toString()));
    });
  }



}