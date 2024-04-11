import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, SocialStates state)
      {

      },

      builder: (BuildContext context, SocialStates state)
      {
        return ConditionalBuilder(
          condition: state is! SocialGetUserLoadingState && state is! SocialGetPostsLoadingState,

          builder: (BuildContext context)
          {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children:
                [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children:
                      [
                        Image(
                          image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-cheerful-afro-american-woman-makes-okay-gesture-agrees-with-good-proposal_273609-25986.jpg?w=996'),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListView.separated(
                    shrinkWrap: true,

                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (BuildContext context, int index) => buildPostItem(
                      SocialCubit.get(context).posts[index],
                      index,
                      context,
                    ),

                    itemCount: SocialCubit.get(context).posts.length,

                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.0,),
                  ),
                ],
              ),
            );
          },

          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, index, context)
  {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children:
          [
            Row(
              children:
              [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),

                SizedBox(
                  width: 20.0,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            width: 5.0,
                          ),

                          Icon(
                            Icons.verified_rounded,
                            color: Colors.blue,
                            size: 18.0,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 6.0,
                      ),

                      Text(
                        '${model.dateTime}',
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 20.0,
                ),

                IconButton(
                  onPressed: ()
                  {

                  },
                  icon: Icon(
                    Icons.more_horiz,
                    size: 18.0,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),

            Text(
              '${model.text}',
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children:
                  [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 6.0,
                      ),
                      child: SizedBox(
                        child: MaterialButton(
                          onPressed: ()
                          {

                          },
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        height: 25.0,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 6.0,
                      ),
                      child: SizedBox(
                        child: MaterialButton(
                          onPressed: ()
                          {

                          },
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#flutter',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        height: 25.0,
                      ),
                    ),
                  ],

                ),
              ),
            ),

            if(model.postImage != '')
              Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 15.0,
              ),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: NetworkImage('${model.postImage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children:
                          [
                            Icon(
                              Icons.favorite_border,
                              size: 16.0,
                              color: Colors.red,
                            ),

                            SizedBox(
                              width: 5.0,
                            ),

                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                          [
                            Icon(
                              Icons.chat_outlined,
                              size: 16.0,
                              color: Colors.amber,
                            ),

                            SizedBox(
                              width: 5.0,
                            ),

                            Text(
                              '0 comment',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),

            Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children:
                      [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                        ),

                        SizedBox(
                          width: 15.0,
                        ),

                        Text(
                          'write a comment ...',
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                ),

                InkWell(
                  child: Row(
                    children:
                    [
                      Icon(
                        Icons.favorite_border,
                        size: 16.0,
                        color: Colors.red,
                      ),

                      SizedBox(
                        width: 5.0,
                      ),

                      Text(
                        'Like',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
