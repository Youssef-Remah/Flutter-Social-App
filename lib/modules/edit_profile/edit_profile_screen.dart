import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(

      listener: (BuildContext context, SocialStates state)
      {

      },

      builder: (BuildContext context, SocialStates state)
      {
        var userModel = SocialCubit.get(context).userModel;

        var profileImage = SocialCubit.get(context).profileImage;

        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel!.bio!;
        phoneController.text = userModel!.phone!;


        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions:
            [
              TextButton(
                onPressed: ()
                {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: const Text(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  'UPDATE',
                ),
              ),

              const SizedBox(
                width: 15.0,
              )
            ],
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  if(state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
            
                  SizedBox(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:
                      [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children:
                            [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: (coverImage == null)
                                        ? NetworkImage('${userModel?.cover}')
                                        : FileImage(coverImage) as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              
                              IconButton(
                                onPressed: ()
                                {
                                 SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 17.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
            
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children:
                          [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: (profileImage == null)
                                    ? NetworkImage('${userModel?.image}')
                                    : FileImage(profileImage) as ImageProvider<Object>?,
                              ),
                            ),
            
                            IconButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 17.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            
                  const SizedBox(
                    height: 20.0,
                  ),
            
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
            
                    Row(
                    children:
                    [
            
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children:
                            [
                              ElevatedButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                child: const Text('upload profile'),
                              ),

                              if(state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                height: 5.0,
                              ),

                              if(state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                      ),
            
                      const SizedBox(
                        height: 5.0,
                      ),
            
                      if(SocialCubit.get(context).coverImage != null)
            
                        Expanded(
                          child: Column(
                            children:
                            [
                              ElevatedButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                child: const Text('upload cover'),
                              ),

                              if(state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                height: 5.0,
                              ),

                              if(state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                      ),
                    ],
                  ),
            
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                    height: 20.0,
                  ),
            
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person_2_outlined),
                    ),
                    validator: (String? nameValue)
                    {
                      if(nameValue == null || nameValue.isEmpty)
                      {
                        return 'Name Must Not be Empty!';
                      }
                      else
                      {
                        return null;
                      }
            
                    },
                  ),
            
                  const SizedBox(
                    height: 15.0,
                  ),
            
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Bio',
                      prefixIcon: const Icon(Icons.info_outline),
                    ),
                    validator: (String? bioValue)
                    {
                      if(bioValue == null || bioValue.isEmpty)
                      {
                        return 'Bio Must Not be Empty!';
                      }
                      else
                      {
                        return null;
                      }
            
                    },
                  ),
            
                  const SizedBox(
                    height: 15.0,
                  ),
            
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    validator: (String? phoneValue)
                    {
                      if(phoneValue == null || phoneValue.isEmpty)
                      {
                        return 'Please Enter your Phone Number';
                      }
                      else
                      {
                        return null;
                      }
            
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
