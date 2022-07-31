// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_string_interpolations
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../constants/constants.dart';
import '../cubit/register cubit/RegisterStates.dart';
import '../cubit/register cubit/registerCubit.dart';
import '../layout/AppLayout.dart';
import '../network/local.dart';
import '../style/icons_broken.dart';


class AppRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var fomKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is AppCreateUserSuccessState){
            CashHelper.saveData(key: 'uId', value:state.uId).then((value){
              ShowToast(msg: 'successfully registered', states: ToastStates.SUCCESS);
              navigateAndFinish(context, AppLayout());
            });
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: fomKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: defaultColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Register now to communicate with friends',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        defaultTextFiled(
                            MyController: nameController,
                            myPrefixIcon: IconBroken.Profile,
                            isPassword: false,
                            validation: (value){
                              if(value.isEmpty){
                                return 'name must not be empty';
                              }
                              return null;
                            },
                            labelTxt: 'name',
                            radius: BorderRadius.circular(5),
                            txtType: TextInputType.text
                        ),
                        SizedBox(height: 15),
                        defaultTextFiled(
                            MyController: emailController,
                            myPrefixIcon: IconBroken.Message,
                            isPassword: false,
                            validation: (value){
                              if(value.isEmpty){
                                return 'email must not be empty';
                              }
                              return null;
                            },
                            labelTxt: 'Email',
                            radius: BorderRadius.circular(5),
                            txtType: TextInputType.emailAddress
                        ),
                        SizedBox(height: 15),
                        defaultTextFiled(
                          MyController: passwordController,
                          myPrefixIcon: IconBroken.Password,
                          validation: (value){
                            if(value.isEmpty){
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          labelTxt: 'Password',
                          radius: BorderRadius.circular(5),
                          txtType: TextInputType.visiblePassword,
                          mySuffixIconBtn:AppRegisterCubit.get(context).IsVisible? IconBroken.Hide:Icons.visibility,
                          isPassword: AppRegisterCubit.get(context).IsVisible,
                          suffixPressed: (){
                            AppRegisterCubit.get(context).ChangeVisibility();
                          },
                        ),
                        SizedBox(height: 15),
                        defaultTextFiled(
                            MyController: phoneController,
                            myPrefixIcon: IconBroken.Call,
                            isPassword: false,
                            validation: (value){
                              if(value.isEmpty){
                                return 'Phone must not be empty';
                              }
                              return null;
                            },
                            labelTxt: 'Phone',
                            radius: BorderRadius.circular(5),
                            txtType: TextInputType.phone
                        ),
                        SizedBox(height: 40),

                        ConditionalBuilder(
                          condition: state is! AppRegisterLoadingState,
                          builder: (context) => defaultButton(
                              fun: () {
                                if (fomKey.currentState!.validate()) {
                                  AppRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      context: context
                                  );
                                }
                              },
                              color: defaultColor,
                              Txt: 'login'
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
