import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{

  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  int currentIndex = 0;

  List<Widget> screens =
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles =
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  File? profileImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);

      emit(SocialProfileImagePickedSuccessState());
    }
    else
    {
      print('No Image Selected');

      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);

      emit(SocialCoverImagePickedSuccessState());
    }
    else
    {
      print('No Image Selected');

      emit(SocialCoverImagePickedErrorState());
    }
  }

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .get()
      .then((value){
        //print(value.data());

        userModel = SocialUserModel.fromJson(value.data()!);
        emit(SocialGetUserSuccessState());
      })
      .catchError((error){

        print(error.toString());
        emit(SocialGetUserErrorState(error.toString()));
      });

  }

  void changeBottomNav(int index)
  {
    if(index == 2)
    {

      emit(SocialNewPostState());
    }
    else
    {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }

  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
      .ref()
      .child('users/${Uri.file(profileImage!.path)
      .pathSegments.last}')
      .putFile(profileImage!)
      .then((p0){
        p0.ref.getDownloadURL().then((value)
        {
          //emit(SocialUploadProfileImageSuccessState());

          updateUser(
            name: name,
            phone: phone,
            bio: bio,
            image: value,
          );

        }).catchError((error)
        {
          emit(SocialUploadProfileImageErrorState());
        });
      })
      .catchError((error)
      {
        emit(SocialUploadProfileImageErrorState());
      });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path)
        .pathSegments.last}')
        .putFile(coverImage!)
        .then((p0){
      p0.ref.getDownloadURL().then((value)
      {
        //emit(SocialUploadCoverImageSuccessState());

        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );

      }).catchError((error)
      {
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // })
  // {
  //   emit(SocialUserUpdateLoadingState());
  //
  //   if(coverImage != null)
  //   {
  //     uploadCoverImage();
  //   }
  //   else if(profileImage != null)
  //   {
  //     uploadProfileImage();
  //   }
  //   else if(coverImage != null && profileImage != null)
  //   {
  //
  //   }
  //   else
  //   {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  })
  {
    SocialUserModel model = SocialUserModel(
      uId: uId,
      name: name,
      email: userModel!.email,
      phone: phone,
      bio: bio,
      cover: cover?? userModel!.cover,
      image: image?? userModel!.image,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value)
    {
      getUserData();
    })
        .catchError((error)
    {
      emit(SocialUserUpdateErrorState());
    });
  }

}