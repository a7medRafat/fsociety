import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/constants/constants.dart';
import 'package:fsociety/cubit/App%20cubit/AppCubit.dart';
import 'package:fsociety/cubit/App%20cubit/AppStates.dart';
import 'package:fsociety/style/icons_broken.dart';

import '../components/components.dart';
class EditProfileScreen extends StatelessWidget {

  var myNameController = TextEditingController();
  var myBioController = TextEditingController();
  var myPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit  = AppCubit.get(context);
        myNameController.text = '${cubit.userModel!.name}';
        myBioController.text = '${cubit.userModel!.bio}';
        myPhoneController.text = '${cubit.userModel!.phone}';
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('edit profile',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 25
            ),
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black38,
                child: Icon(
                  IconBroken.Arrow___Left_2,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(State is AppGetUserDataLoadingStates)
                  LinearProgressIndicator(),
                if(State is AppGetUserDataLoadingStates)
                  SizedBox(height: 10),
                CoverAndProfileEdit(context,cubit),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      defaultTextFiled(
                          MyController: myNameController,
                          myPrefixIcon: IconBroken.User1,
                          validation: (value){
                            if(value.isEmpty){
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          labelTxt: 'name',
                          radius: BorderRadius.zero,
                          txtType: TextInputType.name,
                          isPassword: false
                      ),
                      const SizedBox(height: 10),
                      defaultTextFiled(
                          isPassword: false,
                          MyController: myBioController,
                          myPrefixIcon: IconBroken.Info_Circle,
                          validation: (value){
                            if(value.isEmpty){
                              return 'bio must not be empty';
                            }
                            return null;
                          },
                          labelTxt: 'bio',
                          radius: BorderRadius.zero,
                          txtType: TextInputType.name
                      ),
                      const SizedBox(height: 10),
                          defaultTextFiled(
                              isPassword: false,
                          MyController: myPhoneController,
                          myPrefixIcon: IconBroken.Call,
                          validation: (value){
                            if(value.isEmpty){
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          labelTxt: 'phone',
                          radius: BorderRadius.zero,
                          txtType: TextInputType.phone
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget CoverAndProfileEdit(context , AppCubit cubit)=> Container(
    height: 190,
    child: Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Align(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration:  BoxDecoration(
                    borderRadius:
                    BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AppCubit.get(context).coverImage == null?
                        NetworkImage('${cubit.userModel!.cover}')
                            :FileImage(cubit.coverImage!)as ImageProvider
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        AppCubit.get(context).getCoverImage();
                      },
                      icon: const Icon(
                        IconBroken.Camera,
                        color: Colors.white,
                        size: 16,
                      )),
                  radius: 16.0,
                ),
              ),
            ],
          ),
          alignment: Alignment.topCenter,
        ),
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor,
                ),
                child: CircleAvatar(
                  radius: 58,
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor,
                  child:  CircleAvatar(
                      radius: 55,
                      backgroundImage:cubit.profileImage == null?
                      NetworkImage('${cubit.userModel!.image}'):
                      FileImage(cubit.profileImage!)as ImageProvider
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 25,
                bottom: 10
              ),
              child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).getProfileImage();
                    },
                    icon: const Icon(
                      IconBroken.Camera,
                      color: Colors.white,
                      size: 16,
                    )),
                radius: 16.0,
              ),
            ),
          ],
        ),
        Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if(cubit.profileImage != null || cubit.coverImage!=null)
                    Row(
                    children: [
                      if(cubit.coverImage != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFefefef),
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                cubit.uploadCoverImage(
                                  name: myNameController.text,
                                  bio: myBioController.text,
                                  phone: myPhoneController.text,
                                );
                              },
                              child:  Text('COVER',style: Theme.of(context).textTheme.caption!.copyWith(
                                color: defaultColor,
                                fontSize: 12
                              ),
                              ),
                            ),
                      ),
                            SizedBox(height: 1),
                            if(State is AppUploadCoverImageLoadingState)
                              CircularProgressIndicator()
                          ],
                        ),
                      SizedBox(width: 5),
                      if(cubit.profileImage != null)
                        Container(
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFefefef),
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            cubit.uploadProfileImage(
                              name: myNameController.text,
                              bio: myBioController.text,
                              phone: myPhoneController.text,

                            );
                          },
                          child:  Text('PROFILE',style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 12,
                              color: defaultColor
                          ),),
                        ),
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                  SizedBox(width: 5),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFefefef),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        cubit.updateUserData(
                            name: myNameController.text,
                            bio: myBioController.text,
                            phone: myPhoneController.text);
                      },
                      child:  Text('UPDATE',style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 12,
                          color: defaultColor
                      ),),
                    ),
                  ),
                ],
              )
            )
        ),

      ],
    ),
  );
}
