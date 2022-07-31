
import '../components/components.dart';
import '../constants/constants.dart';
import '../cubit/App cubit/AppCubit.dart';
import '../cubit/App cubit/AppStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local.dart';
import '../style/icons_broken.dart';
import 'LoginScreen.dart';


class SettingsScreen extends StatelessWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var userModel = AppCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            title: Text('edit profile',style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 25
            ),),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(5.0),
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration:   const BoxDecoration(
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            image: DecorationImage(
                                image: NetworkImage('https://img.freepik.com/free-photo/portrait-teenage-girl-listening-music_23-2149238447.jpg?t=st=1649212767~exp=1649213367~hmac=cb7e5f0f5759471134d6cd9aca465893a186e35f4acac1bfe685cd9769f1a287&w=740',
                                ),
                                fit: BoxFit.cover
                            ),
                          ),

                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: CircleAvatar(
                          radius: 63,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child:   CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage('https://img.freepik.com/free-photo/portrait-teenage-girl-listening-music_23-2149238447.jpg?t=st=1649212767~exp=1649213367~hmac=cb7e5f0f5759471134d6cd9aca465893a186e35f4acac1bfe685cd9769f1a287&w=740'),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a7med rafat',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 5),
                Text(
                  'bio',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                'post',
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height:10),
                              Text(
                                '27',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                'following',
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height:10),
                              Text(
                                '88',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                'followers',
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height:10),
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                'likes',
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height:10),
                              Text(
                                '700',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlineButton(
                          onPressed: (){},
                          child: Text(
                            'add photos',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: defaultColor),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      OutlineButton(
                        onPressed: (){},
                        child: const Icon(IconBroken.Edit,
                          size: 20,
                          color: defaultColor,
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20),
                OutlineButton(
                  onPressed: (){
                    CashHelper.removeData(key: 'uId').then((value){
                      navigateAndFinish(context, AppLoginScreen());
                    }).catchError((error){
                      print(error.toString());
                    });
                  },
                  child: Text('LOG OUT'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
