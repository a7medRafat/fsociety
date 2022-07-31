import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:fsociety/models/CommentModel.dart';
import 'package:fsociety/models/PostModel.dart';
import '../components/components.dart';
import '../constants/constants.dart';
import '../cubit/App cubit/AppCubit.dart';
import '../cubit/App cubit/AppStates.dart';
import '../style/icons_broken.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatelessWidget {

  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var model  = AppCubit.get(context).userModel;
        return Scaffold(
          extendBodyBehindAppBar: true,
            body: ConditionalBuilder(
                condition: AppCubit.get(context).userModel != null
                    &&AppCubit.get(context).posts.isNotEmpty,

                builder: (context){
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // if(model!.isEmailVerified == false)
                        //   Container(
                        //     color: Colors.amber[400],
                        //     child: Padding(
                        //       padding:  const EdgeInsets.symmetric(horizontal: 10),
                        //       child: Row(
                        //         children:  [
                        //           const Icon(IconBroken.Info_Circle),
                        //           const SizedBox(width: 10),
                        //           const Text(
                        //             'please verify your email',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 color: Colors.black
                        //             ),
                        //           ),
                        //           const Spacer(),
                        //           TextButton(
                        //               onPressed: (){
                        //                 FirebaseAuth.instance.currentUser!.sendEmailVerification()
                        //                     .then((value) {
                        //                   ShowToast(msg: 'Check your email', states: ToastStates.SUCCESS);
                        //                 })
                        //                     .catchError((error){});
                        //               },
                        //               child: const Text('Send',style: TextStyle(
                        //                   fontSize: 20
                        //               ),)
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        Container(
                          height: 400,
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            ),
                            elevation: 10,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Image(

                                    height: 200.0,
                                    width: double.infinity,
                                    image: AssetImage('images/group.jpg',),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Row(
                                    children: [
                                      Text('F-society',style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: 'script',
                                        color: Colors.grey[800]
                                      )),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Icon(IconBroken.Notification,color: Colors.white),
                                              SizedBox(width: 3),
                                              Text('Notification',style: Theme.of(context).textTheme.caption!.copyWith(
                                                color: Colors.white
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Colors.amber.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(IconBroken.Plus,color: Colors.white,),
                                          ))


                                    ],
                                  ),

                                ),
                              ],
                            ),
                          ),

                        ),
                        SizedBox(height: 15),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>buildPostItems(
                              context,AppCubit.get(context).posts[index],index),
                          separatorBuilder: (context,index)=>const SizedBox(height: 10),
                          itemCount: AppCubit.get(context).posts.length,
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context)=>const Center(child: CircularProgressIndicator())
            )
        );
      },
    );
  }
  Widget buildPostItems(BuildContext context, PostModel postModel,index)=>Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${postModel.image}'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:  [
                          Text(
                            '${postModel.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 18,
                          ),
                        ],
                      ),
                      Text('${postModel.dateTime}',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                FocusedMenuHolder(
                  onPressed: (){},
                  menuWidth: MediaQuery.of(context).size.width*0.50,
                  menuBoxDecoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  duration: Duration(milliseconds: 100),
                  animateMenuItems: true,
                  openWithTap: true,
                  blurSize: 5.0,
                  bottomOffsetHeight: 100,
                  menuItemExtent: 45,
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(title: Text('Save',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14,)),onPressed: (){}),
                    FocusedMenuItem(title: Text('Delete',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    )), trailingIcon: Icon(IconBroken.Delete,color: Colors.white, size: 20) ,backgroundColor: Colors.redAccent, onPressed: (){
                      AppCubit.get(context).deletePost(postId: AppCubit.get(context).postsId[index]);
                    }
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10
                    ),
                    child: Icon(IconBroken.More_Circle,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myDivider(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    bottom: 5
                  ),
                  child: Text('${postModel.text}',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black,
                      fontSize: 15,
                      height: 1.2
                    ),
                  ),
                ),
                if(postModel.postImage != '')
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10
                    ),
                    child: Container(
                    width: double.infinity,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image:  DecorationImage(
                        fit: BoxFit.cover,
                        image:  NetworkImage('${postModel.postImage}'),

                      ),
                    ),
                ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8
              ),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFefefef)
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            AppCubit.get(context).postLike(AppCubit.get(context).postsId[index],index);
                          },
                          icon:  Icon(IconBroken.Heart,
                            size: 25,
                            color: AppCubit.get(context).colors[index],
                          ),
                          padding: EdgeInsets.zero,
                        ),
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('${AppCubit.get(context).likes[index]}',
                            style: TextStyle(
                            fontSize: 12,
                              fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                            fontFamily: 'arial'
                          ),),
                        )
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFefefef)
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).getComments(
                                    postsId:AppCubit.get(context).postsId[index]).then((value) {
                                  showModalBottomSheet(
                                      backgroundColor: Color(0xFFefefef),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25),
                                          )
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 5,
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: Colors.grey[700],
                                                      ),
                                                      height: 7,
                                                      width: 50,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 5,
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.separated(
                                                  itemBuilder: (context, index) => buildCommentItem(context,AppCubit.get(context).comments[index]),
                                                  separatorBuilder: (context,index)=>SizedBox(height:1),
                                                  itemCount: AppCubit.get(context).comments.length
                                              ),
                                            ),
                                          ],
                                        );

                                      }
                                  );
                                });
                              },
                              icon:  Icon(IconBroken.Chat,
                                size: 25,
                                color: Colors.grey,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                             Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('0',style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                fontFamily: 'arial'
                              ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFefefef)
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: (){},
                            icon:  Icon(IconBroken.Arrow___Up_Circle,
                              size: 25,
                              color: Colors.grey,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('10',style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontFamily: 'arial'
                            ),),
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey[300],

              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: commentController,
                      style: TextStyle(
                        fontSize: 14
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xFFefefef),
                        filled: true,
                        hintText: 'write a comment ..',
                        hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.black,
                        ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 30,
                              width: 50,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white
                              ),
                              child: InkWell(
                                onTap: (){
                                  AppCubit.get(context)
                                      .sendComment(
                                      AppCubit.get(context).postsId[index],
                                      '${DateFormat.E().format(now).toString() } at ${DateFormat.Hm().format(now).toString()} ',
                                      commentController.text,
                                    index
                                  );
                                },
                                child: Icon(IconBroken.Send,
                                size: 20,),
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                          ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),



          ],
        ),
      )
  );
  Widget buildCommentItem(context , CommentModel model)=>Container(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 5
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.name}',style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(height: 3),
                  Text('${model.commentTxt}',style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 15
                  ),
                  ),
                  SizedBox(height: 8),
                  Text('${model.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(
                    color: defaultColor
                  ))

                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
