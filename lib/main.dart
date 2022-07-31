import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/shared/bloc_observer.dart';
import 'package:fsociety/style/style.dart';
import 'constants/constants.dart';
import 'cubit/App cubit/AppCubit.dart';
import 'cubit/App cubit/AppStates.dart';
import 'firebase_options.dart';
import 'layout/AppLayout.dart';
import 'modules/LoginScreen.dart';
import 'network/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget? widget;

  uId = await CashHelper.getData(key: 'uId');
  print('uid from main ${uId}');

  if (uId != null) {
    widget = const AppLayout();
  } else {
    widget = AppLoginScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}


class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..getUserData()..getPosts()..getAllUsers(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'flutter demo',
            theme: LightTheme,
            home: startWidget,
          );
        },

      ),
    );
  }
}

