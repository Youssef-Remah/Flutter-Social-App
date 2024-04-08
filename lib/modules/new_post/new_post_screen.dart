import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(

      listener: (BuildContext context, SocialStates state)
      {

      },

      builder: (BuildContext context, SocialStates state)
      {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions:
              [
                TextButton(
                  onPressed: ()
                  {
                    var now = DateTime.now();

                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    }
                    else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                  },
                  child: const Text('Post'),
                ),
              ]
          ),

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
               if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),

                if(state is SocialCreatePostLoadingState)
                  const SizedBox(
                  height: 10.0,
                ),

                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/joyful-dark-skinned-woman-with-satisfied-facial-expression-curly-hair-points-sideways-keeps-arms-crossed-chest-being-high-spirit-dressed-oversized-rosy-sweater-isolated-purple-wall_273609-26410.jpg?w=996'),
                    ),

                    SizedBox(
                      width: 20.0,
                    ),

                    Expanded(
                      child: Text(
                        SocialCubit.get(context).userModel!.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                    controller: textController,
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),

                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children:
                  [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20.0,
                ),

                Row(
                  children:
                  [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(Icons.image_outlined),

                            SizedBox(
                              width: 5.0,
                            ),

                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {

                        },
                        child: Text('# tags'),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
