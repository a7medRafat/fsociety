import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/cubit/App%20cubit/AppCubit.dart';
import '../../models/UserModel.dart';
import 'RegisterStates.dart';

class AppRegisterCubit extends Cubit <AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);

  bool IsVisible = true;

  IconData SUffix = Icons.visibility;

  void ChangeVisibility() {
    IsVisible = !IsVisible;
    emit(AppRegisterChangeVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  })
  {
    emit(AppRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      UserCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
        context: context
      );
    }).catchError((error){
      emit(AppRegisterErrorState());
    });
  }


  void UserCreate ({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required BuildContext context,
  }){

    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio here..',
      image: 'https://img.freepik.com/free-photo/portrait-teenage-girl-listening-music_23-2149238447.jpg?t=st=1649212767~exp=1649213367~hmac=cb7e5f0f5759471134d6cd9aca465893a186e35f4acac1bfe685cd9769f1a287&w=740',
      cover: "https://img.freepik.com/free-photo/three-young-excited-men-jumping-together_171337-36887.jpg?w=996",
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection('users')
        .doc(uId).set(model.toMap()).then((value) {
          AppCubit.get(context).getUserData();
      emit(AppCreateUserSuccessState(uId));
    }).catchError((error){
      emit(AppCreateUserErrorState(error.toString()));
    });
  }
}