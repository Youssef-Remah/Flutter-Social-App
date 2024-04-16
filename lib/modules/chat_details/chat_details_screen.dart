import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen
  ({
    super.key,
    required this.userModel,
  });

  var messageController = TextEditingController();

  SocialUserModel userModel;

  @override
  Widget build(BuildContext context)
  {
    return Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId);

        return BlocConsumer<SocialCubit, SocialStates>(

          listener: (BuildContext context, SocialStates state)
          {

          },

          builder: (BuildContext context, SocialStates state)
          {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),

                    SizedBox(
                      width: 15.0,
                    ),

                    Text(
                        '${userModel.name}'
                    ),
                  ],
                ),
              ),

              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,

                builder: (BuildContext context)
                {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children:
                      [
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),

                            itemBuilder: (BuildContext context, int index)
                            {
                              var message = SocialCubit.get(context).messages[index];
                          
                              if(SocialCubit.get(context).userModel!.uId == message.senderId)
                              {
                                return buildMyMessage(message);
                              }
                          
                              return buildMessage(message);
                            },
                          
                            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15.0,),
                          
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children:
                            [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ...',
                                    ),
                                    controller: messageController,
                                  ),
                                ),
                              ),

                              Container(
                                height: 50.0,
                                color: Colors.blue,
                                child: MaterialButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                  },
                                  minWidth: 1.0,
                                  child: Icon(
                                    Icons.send,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },

                fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model)
  {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
            '${model.text}'
        ),
      ),
    );
  }

  Widget buildMyMessage(MessageModel model)
  {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
            '${model.text}'
        ),
      ),
    );
  }

}
