import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/App cubit/AppCubit.dart';
import '../cubit/App cubit/AppStates.dart';
import '../style/icons_broken.dart';

class AppLayout extends StatelessWidget {

  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var cubit = AppCubit.get(context);
        return  Scaffold(
          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: cubit.currentIndex,
            unselectedItemColor: Colors.black,
            onTap: (index){
              cubit.changeBottomNavBar(context,index);
            },
            items:  [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Activity),
                  label: 'Chat'
              ),
              const BottomNavigationBarItem(
                  icon: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,

                      ),
                  ),
                  label: 'new post',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(IconBroken.Search),
                  label: 'users'
              ),
              BottomNavigationBarItem(
                  icon: Stack(
                    children:  [
                      ConditionalBuilder(
                        condition:AppCubit.get(context).userModel!=null ,
                        builder:(context)=>CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                            ),
                          ),
                        ),
                        fallback: (context)=>CircularProgressIndicator(),

                      ),

                    ],
                  ),
                  label: 'profile'
              ),
            ],
          ),
        );
      },
    );

  }
}