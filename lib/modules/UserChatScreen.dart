import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/cubit/App%20cubit/AppCubit.dart';
import 'package:fsociety/cubit/App%20cubit/AppStates.dart';
import 'package:fsociety/models/MessageModel.dart';
import 'package:fsociety/models/UserModel.dart';

import '../constants/constants.dart';
import '../style/icons_broken.dart';

class UserChatScreen extends StatelessWidget {

  UserModel userModel;
  UserChatScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getMessages(receiverId: userModel.uId!);
        return  BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
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
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${userModel.name}',style: Theme.of(context).textTheme.bodyText1,),
                        Text('online',style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.more_vert_rounded)
                  )
                ],
              ),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFFefefef),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF76b5c5),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 10,
                                right: 10
                            ),
                            child: Text('Today',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 12
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if(AppCubit.get(context).Messages.isEmpty)
                        Center(child:  Text('there is no messages yet',
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              var message = AppCubit.get(context).Messages[index];
                              if(uId == message.senderId){
                                return sender(context,message);
                              }
                              return receiver(context,message);
                            },
                            separatorBuilder: (context,index)=>const SizedBox(height:10),
                            itemCount: AppCubit.get(context).Messages.length
                        ),
                      ),
                      if(AppCubit.get(context).messageImage !=null)
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
                                      image: FileImage(AppCubit.get(context).messageImage!) as ImageProvider
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
                                    AppCubit.get(context).removeMessageImage();
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: AppCubit.get(context).messageController,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  fillColor:  Colors.white,
                                  filled: true,
                                  hintText: 'type your message..',
                                  hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey[500],
                                      fontSize: 15
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10
                                    ),
                                    child: IconButton(
                                      icon: Icon(IconBroken.Image),
                                      onPressed: (){
                                        AppCubit.get(context).getMessageImage();
                                      },
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue.withOpacity(0.1),
                                      child: IconButton(
                                        icon: Icon(IconBroken.Send,
                                            color: AppCubit.get(context).sendColor
                                        ),
                                        onPressed: (){
                                         if(AppCubit.get(context).messageImage == null){
                                           AppCubit.get(context).sendMessage(
                                               text:AppCubit.get(context).messageController.text ,
                                               dateTime: DateTime.now().toString(),
                                               receiverId: userModel.uId!
                                           );
                                         }
                                         else{
                                           AppCubit.get(context).sendMessageImage(
                                               text: AppCubit.get(context).messageController.text,
                                               dateTime: DateTime.now().toString(),
                                               receiverId: userModel.uId!
                                           );
                                         }
                                        },
                                      ),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none
                                  ),
                                ),
                                onChanged: (value){
                                  AppCubit.get(context).changeMessageIcon();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget receiver(context,MessageModel messageModel)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd:const Radius.circular(20),
                topStart:const Radius.circular(20),
                topEnd: Radius.circular(10),
              )
          ),
          child: Text('${messageModel.text}',style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 15
          )),
        ),
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image:  DecorationImage(
                fit: BoxFit.cover,
                image:  NetworkImage('${messageModel.messageImage}'),

              ),
            ),
          ),
      ],
    ),
  );


  Widget sender(context,MessageModel messageModel)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.3),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart:const Radius.circular(10),
            topStart:const Radius.circular(10),
            topEnd: const Radius.circular(10),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(messageModel.messageImage != '')
              image(messageModel),
          if(messageModel.text !='')
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${messageModel.text}',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15
            )),
          ),
        ],
      ),
    ),
  );

  Widget image(MessageModel messageModel)=> Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.green,
      image:  DecorationImage(
        fit: BoxFit.cover,
        image:  NetworkImage('${messageModel.messageImage}'),

      ),
    ),
  );
}
