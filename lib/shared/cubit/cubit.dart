import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/states.dart';

class SocialCubit extends Cubit<SocialStates>
{

  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

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

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .get()
      .then((value){
        //print(value.data());

        model = SocialUserModel.fromJson(value.data()!);
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

}