import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit, SocialStates>(

      listener: (BuildContext context, SocialStates state)
      {

      },

      builder: (BuildContext context, SocialStates state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,

          builder: (BuildContext context)
          {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: SocialCubit.get(context).users.length,
            );
          },

          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context)
  {
    return InkWell(
      onTap: ()
      {
        Navigator.push(
          context,
            MaterialPageRoute(
              builder: (BuildContext context) => ChatDetailsScreen(userModel: model),
            ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children:
          [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('${model.image}'),
            ),

            SizedBox(
              width: 20.0,
            ),

            Text(
              '${model.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
