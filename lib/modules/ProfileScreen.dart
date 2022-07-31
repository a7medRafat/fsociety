import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fsociety/components/components.dart';
import 'package:fsociety/modules/EditProfileScreen.dart';
import 'package:fsociety/style/icons_broken.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black38,
              child: const Icon(
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
            Container(
              height: 500,
              color: Colors.amber,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const NetworkImage('https://img.freepik.com/free-photo/white-chairs-table-beach_1339-4293.jpg?t=st=1658172196~exp=1658172796~hmac=71e0a7623f8365f6c4c44c9498f99c4ee801cd8f8e6fb0180894850c8ee763fa&w=740'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.7),
                            BlendMode.darken
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      profilePicAndBio(context),
                      const Spacer(),
                      profileFollowers(context),
                      const SizedBox(height: 25),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
               children: [
                 Expanded(
                   child: InkWell(
                     onTap: (){
                       navigateTo(context,  EditProfileScreen());
                     },
                     child: Container(
                       alignment: AlignmentDirectional.center,
                       height:35,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Color(0xFFefefef)
                         ),
                         child: Text('Edit Profile',
                           style: Theme.of(context).textTheme.bodyText1,)),
                   ),
                 ),
                 SizedBox(width: 5),
                 Container(
                     alignment: AlignmentDirectional.center,
                     height:35,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Color(0xFFefefef)
                     ),
                     child: IconButton(
                       icon: Icon(Icons.more_horiz),
                       onPressed: (){
                         showModalBottomSheet(
                             shape:  RoundedRectangleBorder(
                               borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(15.0),
                                   topRight: Radius.circular(15.0)),
                             ),
                             context: context,
                             builder: (context){
                               return Container(
                                 height: 120,
                                 width: double.infinity,
                                 child: Column(
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
                                     SizedBox(height: 10),
                                     Padding(
                                       padding: const EdgeInsets.all(10.0),
                                       child: Container(
                                         decoration: BoxDecoration(),
                                         width: double.infinity,
                                         child: OutlinedButton.icon(
                                           label: Text('log out',
                                             style: Theme.of(context).textTheme.bodyText1,
                                           ),
                                           icon: Icon(IconBroken.Logout),
                                           onPressed: () {
                                             print('Pressed');
                                           },
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               );
                             }
                         );
                       },
                     )
                 ),
               ],
              ),
            ),
            SizedBox(height: 40),
            Column(
              children: [
                CircleAvatar(
                  radius:61,
                  backgroundColor: Colors.grey[700],
                  child: CircleAvatar(
                    radius:60,
                    backgroundColor: Colors.white,
                    child: Icon(IconBroken.Plus,
                      size: 60,),
                  ),
                ),
                SizedBox(height: 10),
                Text('No Photos Yet',style: Theme.of(context).textTheme.bodyText1,)
              ],
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
  Widget profileFollowers(context)=>Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFefefef),
          boxShadow:const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7,
              offset: Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('18',style: Theme.of(context).textTheme.bodyText1
            !.copyWith(fontSize: 18,fontFamily: 'arial',)
            ),
            const SizedBox(height: 2),
            Text('Posts',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                color: Colors.black54
            )),

          ],
        ),
      ),

      const SizedBox(width: 15),
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFefefef),
            boxShadow:const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(0, 0), // Shadow position
              ),
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('945',style: Theme.of(context).textTheme.bodyText1
            !.copyWith(
                fontSize: 19,
              fontFamily: 'arial',
            ),
            ),
            const SizedBox(height: 2),
            Text('Followers',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14,
                color: Colors.black54
            )),

          ],
        ),
      ),

      const SizedBox(width: 15),
      Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFefefef),
            boxShadow:const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 7,
                offset: Offset(0, 0), // Shadow position
              ),
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('18',style: Theme.of(context).textTheme.bodyText1
            !.copyWith(fontSize: 18,fontFamily: 'arial',)
            ),
            const SizedBox(height: 2),
            Text('Following',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                color: Colors.black54
            )),

          ],
        ),
      ),

    ],
  );
  Widget profilePicAndBio(context)=>Column(
    children: [
      Container(
        height: 300,
        child: const Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 68,
              backgroundImage: NetworkImage('https://instagram.fcai19-5.fna.fbcdn.net/v/t51.2885-19/293627707_1371811929896192_2247914505650137_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fcai19-5.fna.fbcdn.net&_nc_cat=108&_nc_ohc=hutLdhrr-eQAX8BE5eW&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT9LTbi-uhvo_jxk2QKxSXWZAjNa5aMnpt2c0mO4Whq9bQ&oe=62DC50D4&_nc_sid=8fd12b'),

            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text('a7med Rafat',
          style: Theme.of(context).
          textTheme.bodyText1!.copyWith(
              fontSize: 30,
              color: Colors.white
          )
      ),
      const SizedBox(height: 3),
      Text('software engineer',
        style: Theme.of(context).
        textTheme.caption!.copyWith(
            color: Colors.white70,
            fontSize: 13
        ),
      ),
    ],
  );
  Widget divider(context)=>Container(
    height: 60,
    width: 5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      boxShadow:const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 7,
          offset: Offset(0, 0), // Shadow position
        ),
      ],
    ),
  );
}
