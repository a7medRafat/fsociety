import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/components/components.dart';
import 'package:fsociety/constants/constants.dart';
import 'package:fsociety/cubit/App%20cubit/AppCubit.dart';
import 'package:fsociety/cubit/App%20cubit/AppStates.dart';
import 'package:fsociety/layout/AppLayout.dart';
import 'package:fsociety/style/icons_broken.dart';
import 'package:intl/intl.dart';

class CreatePostScreen extends StatelessWidget {

  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black45,
                  child: Icon(
                    IconBroken.Arrow___Left_2,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              title: Text('create post',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 25,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: (){
                    if (AppCubit.get(context).postImage == null){
                      AppCubit.get(context).createPost(
                        text: postController.text,
                        dateTime: '${DateFormat.yMMMEd().format(now).toString()} at ${DateFormat.jm().format(now).toString()}'
                      ).then((value) {
                        ShowToast(msg: 'post successfully created', states: ToastStates.SUCCESS);
                        AppCubit.get(context).getPosts();
                        navigateTo(context, AppLayout());
                      });
                    }
                    else{
                      AppCubit.get(context).createPostImage(
                          text: postController.text,
                          dateTime: '${DateFormat.yMMMEd().format(now).toString()} at ${DateFormat.jm().format(now).toString()}'
                      ).then((value) {
                        AppCubit.get(context).postImage = null;
                        ShowToast(msg: 'post successfully created', states: ToastStates.SUCCESS);
                      });
                    }
                  },
                  child: Text('Post',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: defaultColor,
                      fontSize: 20
                  )),
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(State is AppCreatePostLoadingState)
                        const LinearProgressIndicator(
                          backgroundColor: Colors.black,
                          color: defaultColor,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 76,
                              backgroundColor: Colors.grey[700],
                              child:  CircleAvatar(
                                radius: 75,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage:  NetworkImage('${AppCubit.get(context).userModel!.image}'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text('${AppCubit.get(context).userModel!.name}',style: Theme.of(context).textTheme
                                .bodyText1!.copyWith(
                                fontSize: 23
                            ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  IconBroken.Lock,
                                  size: 15,
                                ),
                                const SizedBox(width: 3),
                                Text('only me',style: Theme.of(context).textTheme
                                    .caption!.copyWith(
                                    fontSize: 12
                                ),),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            child: TextFormField(
                              controller: postController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFefefef),
                                filled: true,
                                hintText: 'what is in your mind ?',
                                hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                                    color: Colors.grey[500],
                                    fontSize: 15
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if(AppCubit.get(context).postImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration:  BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.only(
                                      topLeft: const Radius.circular(4.0),
                                      topRight: const Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(AppCubit.get(context).postImage!) as ImageProvider
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.black38,
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).removePostImage();
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: (){
                                  AppCubit.get(context).getPostImage();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(IconBroken.Image,color: defaultColor,),
                                    const SizedBox(width: 3),
                                    Text('add photo',style: Theme.of(context).textTheme
                                        .bodyText1!.copyWith(
                                        fontSize: 18,
                                        color: defaultColor
                                    ),),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 5),
                                    Text('# Hashtags',style: Theme.of(context).textTheme
                                        .bodyText1!.copyWith(
                                        fontSize: 18,
                                        color: defaultColor
                                    ),),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                )
              ],
            )
        );
      },
    );
  }
}
