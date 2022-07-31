
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/style/icons_broken.dart';
import '../components/components.dart';
import '../constants/constants.dart';
import '../cubit/login cubit/LoginCubit.dart';
import '../cubit/login cubit/LoginStates.dart';
import '../layout/AppLayout.dart';
import '../network/local.dart';
import 'RegisterScreen.dart';


class AppLoginScreen extends StatelessWidget {

  var fomKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit , AppLoginStates>(
        listener: (BuildContext context, state) {
          if (state is AppLoginSuccessState){
            CashHelper.saveData(key: 'uId', value: state.uid).then((value) {
              ShowToast(msg: 'successfully login', states: ToastStates.SUCCESS);
              navigateAndFinish(context, const AppLayout());
            });
          }
          if (state is AppLoginErrorState){
            ShowToast(msg: state.error.toString(), states: ToastStates.ERROR);
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
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: defaultColor
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text('login now to communicate with friends',
                            style:Theme.of(context).textTheme.headline6!.copyWith(
                                color: Colors.black54
                            )
                        ),
                        const SizedBox(height: 40,),
                        defaultTextFiled(
                            MyController: emailController,
                            myPrefixIcon: IconBroken.Message,
                            validation: (value){
                              if(value.isEmpty){
                                return 'field must not be empty';
                              }
                              return null;
                            },
                            labelTxt: 'E-mail',
                            radius: BorderRadius.circular(5),
                            txtType: TextInputType.emailAddress,
                            isPassword: false
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFiled(
                          MyController: passwordController,
                          myPrefixIcon: IconBroken.Lock,
                          validation: (value){
                            if(value.isEmpty){
                              return 'password is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Password',
                          radius: BorderRadius.circular(5),
                          txtType: TextInputType.visiblePassword,
                          mySuffixIconBtn: AppLoginCubit.get(context).IsVisible? IconBroken.Hide : Icons.visibility,
                          isPassword: AppLoginCubit.get(context).IsVisible,
                          suffixPressed: (){
                            AppLoginCubit.get(context).ChangeVisibility();
                          },
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is ! AppLoginLoadingState ,
                          builder: (context)=>defaultButton(
                              fun: (){
                                if(fomKey.currentState!.validate()){
                                  AppLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    context: context
                                  );
                                }
                              },
                              color: defaultColor,
                              Txt: 'login'
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(
                                      context,
                                      AppRegisterScreen());
                                },
                                child: const Text(
                                    'Register Now'
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            const Text('OR',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              MaterialButton(
                                height: 40,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: const BorderSide(
                                      color: Colors.grey,
                                    )
                                ),
                                onPressed: (){
                                  AppLoginCubit.get(context).google();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      height: 15,
                                      width: 15,
                                      image: AssetImage('images/google.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      'Sign in With google',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              const SizedBox(height: 7),
                              MaterialButton(
                                height: 40,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: const BorderSide(
                                      color: Colors.grey,
                                    )
                                ),
                                onPressed: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      height: 15,
                                      width: 15,
                                      image: AssetImage('images/faceBook.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      'Sign in With faceBook',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
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
