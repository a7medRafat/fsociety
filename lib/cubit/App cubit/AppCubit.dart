import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/models/CommentModel.dart';
import 'package:fsociety/models/MessageModel.dart';
import 'package:fsociety/models/PostModel.dart';
import 'package:fsociety/models/UserModel.dart';
import 'package:fsociety/modules/ProfileScreen.dart';
import 'package:fsociety/modules/UserChatScreen.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/components.dart';
import '../../constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../modules/ChatsScreen.dart';
import '../../modules/CreatePostScreen.dart';
import '../../modules/HomeScreen.dart';
import '../../modules/SearchScreen.dart';
import 'AppStates.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;

  List<Widget> screens = [
     HomeScreen(),
     ChatScreen(),
    CreatePostScreen(),
    SearchScreen(),
     ProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'post',
    'Users',
    'profile'
  ];

  void changeBottomNavBar(context, int index) {

    if (index == 2) {
      navigateTo(context, CreatePostScreen());
      emit(AppWritePostStates());
    }
    else if(index == 4){
      navigateTo(context, ProfileScreen());
      emit(AppProfileScreenStates());
    }
    else if(index == 1){
      navigateTo(context, ChatScreen());
      emit(AppChatScreenStates());
    }
    else if(index == 3){
      navigateTo(context, SearchScreen());
      emit(AppChatScreenStates());
    }
    else {
      currentIndex = index;
      emit(AppChangeNavBarStates());
    }
  }

  UserModel? userModel;
  void getUserData(){
    emit(AppGetUserDataLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().
    then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(AppGetUserDataSuccessStates());
    })
        .catchError((error){
      print('error from get user ${error.toString()}');
      emit(AppGetUserDataErrorStates());
    });

  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(AppProfileImagePickedSuccessState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppCoverImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(AppCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
  required String name,
  required String bio,
  required String phone,
}){
    emit(AppUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
    .ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
    .putFile(profileImage!).then((value) {
      print("Profile image uploaded successfully");
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            image: value
        );
        emit(AppUploadProfileImageSuccessState());
      }).catchError((error){
        emit(AppUploadProfileImageErrorState());
      });
      emit(AppUploadProfileImageErrorState());
    });

  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
}){
    emit(AppUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value){
          value.ref.getDownloadURL().then((value) {
            print("cover image successfully uploaded");
            print(value);
            updateUserData(
                name: name,
                bio: bio,
                phone: phone,
                cover: value
            );
            emit(AppUploadCoverImageSuccessState());
          }).catchError((error){
            emit(AppUploadCoverImageErrorState());
          });
    }).catchError((error){
      emit(AppUploadCoverImageErrorState());
    });
  }

  void updateUserData({
  required String name,
  required String phone,
  required String bio,
    String? image,
    String? cover,

}){
    emit(AppUpdateUserDataLoadingState());
    UserModel model = UserModel(
      name: name ,
      phone: phone,
      bio: bio,
      uId: userModel!.uId,
      email: userModel!.email,
      image:image??userModel!.image,
      cover:cover??userModel!.cover,
      isEmailVerified: false
    );

    FirebaseFirestore.instance.collection('users').doc(uId)
        .update(model.toMap()).then((value) {
          getUserData();
          emit(AppUpdateUserDataSuccessState());
    }).catchError((error){
      emit(AppUpdateUserDataErrorState());
    });
  } 
  
  Future createPost({
    required String text,
    required String dateTime,
    String? postImage
})async{

    PostModel postModel = PostModel(
      image: userModel!.image,
      name: userModel!.name,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postImage: postImage ??''
    );
    emit(AppCreatePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts').add(postModel.toMap()).then((value) {
      emit(AppCreatePostSuccessState());
    }).catchError((error){
      emit(AppCreatePostErrorState());

    });
  }

  File? postImage;
  Future createPostImage({
    required String text,
    required String dateTime,
  })async{
    emit(AppCreatePostImageLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value) {
        print("postImage successfully uploaded");
        createPost(
            text: text,
            dateTime: dateTime,
            postImage: value
        );
        print(value);
        emit(AppCreatePostImageSuccessState());
      }).catchError((error){
        emit(AppCreatePostImageErrorState());
      });
    }).catchError((error){
      emit(AppCreatePostImageErrorState());
    });
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppPostImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(AppPostImagePickedErrorState());
    }
  }

  void removePostImage(){
    postImage = null;
    emit(AppRemovePostImageSuccessState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<UserModel> users = [];
  List<int> commentNum = [];
  List<Color> colors =[];
  List<Color> commentColors =[];

    getPosts() {
    posts = [];
    likes = [];
    colors = [];
    postsId = [];
    commentNum = [];
    emit(AppCreatePostImageLoadingState());
      FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
          element.reference.collection('like').get().then((value) {
            if(value.docs.isEmpty){
              colors.add(Colors.grey);
            }
            else{
              value.docs.forEach((element) {
                if(element.id ==uId){
                  colors.add(Colors.red);
                }else{
                  colors.add(Colors.grey);
                }
              });
            }
            posts.add(PostModel.fromJson(element.data()));
            postsId.add(element.id);
            likes.add(value.docs.length);
            posts.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
          });
      });
      emit(AppGetPostsSuccessState());
     }).catchError((error){
      emit(AppGetPostsErrorState());
    });
  }
  
  void postLike(postId,index){
    emit(AppPostLikeLoadingState());
    FirebaseFirestore.instance.collection('posts').doc(postId)
    .collection('like').get().then((value) {
      if(value.docs.isEmpty){
        FirebaseFirestore.instance.collection('posts')
         .doc(postId).collection('like').doc(uId).set({
          'like':true,
        }).then((value) {
          colors[index] = Colors.red;
          likes[index]++;

          emit(AppGetPostsSuccessState());
        }).catchError((error){
          emit(AppGetPostsErrorState());
        });
      }
      else{
        value.docs.forEach((element) {
          if(element.id == uId){
            postDisLike(postId, index);
            colors[index] = Colors.grey;
            likes[index]--;
          }
          else{
            FirebaseFirestore.instance.collection('posts').
            doc(postId).collection('like').doc(uId).set({
              'like':true,
            }).then((value) {
              colors[index] = Colors.red;
              likes[index]++;
            });
          }
        });
      }
    }).catchError((error){
      emit(AppGetPostsErrorState());
    });

  }

  void postDisLike(postId,index){
    emit(AppPostDisLikeLoadingState());
    FirebaseFirestore.instance.collection('posts').
    doc(postId).collection('like').doc(uId).delete().then((value) {
      emit(AppPostDisLikeSuccessState());
    }).catchError((error){
      emit(AppPostDisLikeErrorState());
    });
  }
  
  List<UserModel> allUsers =[];
  getAllUsers(){
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element) { 
        allUsers.add(UserModel.fromJson(element.data()));
        emit(AppGetAllUsersSuccessState());
      });
    }).catchError((error){
      emit(AppGetAllUsersErrorState());
    });
  }

  List<MessageModel>Messages =[];
  sendMessage({
    required String text,
    required String dateTime,
    required String receiverId,
    String? messageImage,
}){
    
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      senderId: userModel!.uId,
      receiverId: receiverId,
      messageImage: messageImage??''
    );
    FirebaseFirestore.instance.collection('users').doc(uId)
    .collection('chats').doc(receiverId).collection('message')
        .add(messageModel.toMap()).then((value) {

      emit(AppSendMessageSuccessState());
    }).catchError((error){
      emit(AppSendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users').doc(receiverId)
        .collection('chats').doc(uId).collection('message')
        .add(messageModel.toMap()).then((value) {
         messageController.text = '';
      emit(AppSendMessageSuccessState());
    }).catchError((error){
      emit(AppSendMessageErrorState());
    });
  }

  File? messageImage;
  Future<void> getMessageImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppMessageImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(AppMessageImagePickedErrorState());
    }
  }

  void removeMessageImage(){
    messageImage = null;
    emit(AppRemoveMessageImageSuccessState());
  }

  Future sendMessageImage({
    required String text,
    required String dateTime,
    required String receiverId,

})async{
    emit(AppCreatePostImageLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().
    child('messages/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!).then((value){
      value.ref.getDownloadURL().then((value) {
        print("messageImage successfully uploaded");
        print(value);
        sendMessage(
            text: text,
            dateTime: dateTime,
            receiverId: receiverId,
            messageImage: value,
        );
        emit(AppCreateMessageImageLoadingState());
      }).catchError((error){
        emit(AppCreateMessageImageErrorState());
      });
    }).catchError((error){
      emit(AppCreateMessageImageErrorState());
    });
  }


  getMessages({required String receiverId}){
    FirebaseFirestore.instance.collection('users').doc(uId)
        .collection('chats').doc(receiverId)
        .collection('message').orderBy('dateTime',descending: false).snapshots().listen((event) {
            Messages=[];
          event.docs.forEach((element) {
            Messages.add(MessageModel.fromJson(element.data()));
            emit(AppGetMessagesSuccessState());
          });
    });

  }
  
  Future deletePost({required String postId})async{
    emit(AppDeletePostLoadingState());
    await FirebaseFirestore.instance.collection('posts')
        .doc(postId).collection('like').get().then((value) {
          value.docs.forEach((element) {
            element.reference.delete();
          });
          FirebaseFirestore.instance.collection('posts')
          .doc(postId).delete().then((value) {
          });
          getPosts();
          emit(AppDeletePostSuccessState());
          }).catchError((error){
            emit(AppDeletePostErrorState());
          });
  }
  
  void sendComment(postId,dateTime,text,index){
    emit(AppPostCommentLoadingState());
    CommentModel commentModel = CommentModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      commentTxt: text,
    );
    FirebaseFirestore.instance.collection('posts').doc(postId)
        .collection('comment').add(commentModel.toMap()).then((value){
          commentNum[index]++;
          commentColors[index] = Colors.green;
      emit(AppPostCommentSuccessState());
    }).catchError((error){
      emit(AppPostCommentErrorState());
    });
  }

  List <CommentModel> comments =[];
  Future getComments({required postsId})async{
    comments =[];
    emit(AppGetCommentLoadingState());
    await FirebaseFirestore.instance.collection('posts')
        .doc(postsId).collection('comment').get().then((value){
          value.docs.forEach((element) {
            comments.add(CommentModel.fromJson(element.data()));
          });
          emit(AppGetCommentSuccessState());
    }).catchError((error){
      emit(AppGetCommentErrorState());
    });
  }

  

  Color sendColor = Colors.white70;
  var messageController = TextEditingController();
  changeMessageIcon(){
    if(messageController.text.isNotEmpty ){
      sendColor = defaultColor;
    }
    else{
      sendColor = Colors.white70;
    }
    emit(AppSendMessageIconState());
  }




}