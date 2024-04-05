import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, SocialStates state)
      {
        if(state is SocialNewPostState)
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NewPostScreen(),
            ),
          );
        }

      },

      builder: (BuildContext context, SocialStates state)
      {
        SocialCubit cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions:
            [
             IconButton(
               onPressed: (){},
               icon: const Icon(Icons.notifications_none_outlined)
             ),

             IconButton(
               onPressed: (){},
               icon: const Icon(Icons.search_outlined)
             ),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items:
            const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_upload_outlined),
                label: "Post",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                label: "Users",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
