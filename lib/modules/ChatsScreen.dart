import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/components/components.dart';
import 'package:fsociety/cubit/App%20cubit/AppCubit.dart';
import 'package:fsociety/models/UserModel.dart';
import 'package:fsociety/modules/UserChatScreen.dart';

import '../style/icons_broken.dart';

class ChatScreen extends StatelessWidget {

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('chats',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 25,
          ),),
        backgroundColor: Colors.transparent,
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20
                          ),
                          child: Row(
                            children: [
                              Text('Online',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 20,
                              ),),
                              const Spacer(),
                              Text('see all',style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 12,
                              ),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10
                          ),
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context,index)=>buildOnline(AppCubit.get(context).allUsers[index]),
                                separatorBuilder: (context,index)=>const SizedBox(width: 15),
                                itemCount: AppCubit.get(context).allUsers.length
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFefefef),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 5,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[700],
                                    ),
                                    height: 7,
                                    width: 50,
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
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text('Recent chat',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 20,
                                ),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          5
                                      ),
                                      color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.archive_rounded,size: 18),
                                        SizedBox(width: 5),
                                        Text('Archive chat',style: Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 12,
                                        ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 500,
                              child: ListView.separated(
                                shrinkWrap: true,
                                  itemBuilder: (context, index) => buildChatUsers(context,AppCubit.get(context).allUsers[index]),
                                  separatorBuilder: (context,index)=>SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: AppCubit.get(context).allUsers.length
                              ),
                            )


                          ],
                        ),
                      )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget buildOnline(UserModel model)=>  CircleAvatar(
    radius: 34,
    backgroundColor: Colors.black,
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: 33,
      child:  CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage('${model.image}'),
      ),
    ),
  );
  Widget buildChatUsers(context , UserModel model)=> InkWell(
    onTap: (){
      navigateTo(context, UserChatScreen(userModel: model));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}',style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 3),
                Text('there is no message yet',style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 13
                ),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10
              ),
              child: Text('8:00 PM',style: Theme.of(context).textTheme.caption,),
            )
          ],
        ),
      ),
    ),
  );
}
