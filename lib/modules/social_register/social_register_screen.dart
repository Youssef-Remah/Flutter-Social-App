import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/social_register/cubit/cubit.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(

        listener: (BuildContext context, SocialRegisterStates state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            Navigator.pushAndRemoveUntil(
              context,
                MaterialPageRoute<void>(builder: (BuildContext context) => SocialLayout()),
              (route) => false
            );
          }
        },

        builder: (BuildContext context, SocialRegisterStates state)
        {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),

                        const Text(
                          'Sign Up now to communicate with friends!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),

                        const SizedBox(
                          height: 30.0,
                        ),

                        Form(
                          key: formKey,

                          child: Column(
                            children:
                            [
                              TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'User Name',
                                  prefixIcon: const Icon(Icons.person),
                                ),
                                validator: (String? nameValue)
                                {
                                  if(nameValue == null || nameValue.isEmpty)
                                  {
                                    return 'Please Enter your Name!';
                                  }
                                  else
                                  {
                                    return null;
                                  }

                                },
                              ),

                              const SizedBox(
                                height: 30.0,
                              ),

                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Enter your Email',
                                  prefixIcon: const Icon(Icons.email_outlined),
                                ),
                                validator: (String? emailValue)
                                {
                                  if(emailValue == null || emailValue.isEmpty)
                                  {
                                    return 'Email Address Must Not be Empty!';
                                  }
                                  else
                                  {
                                    return null;
                                  }

                                },
                              ),

                              const SizedBox(
                                height: 30.0,
                              ),


                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: cubit.isPasswordVisible? false : true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    labelText: 'Enter your Password',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      onPressed: ()
                                      {
                                        cubit.changePasswordVisibility();
                                      },
                                      icon: Icon(cubit.isPasswordVisible? Icons.visibility_off : Icons.visibility),
                                    )
                                ),
                                validator: (String? passwordValue)
                                {
                                  if(passwordValue == null || passwordValue.isEmpty)
                                  {
                                    return 'Password is Too Short!';
                                  }
                                  else
                                  {
                                    return null;
                                  }

                                },
                              ),

                              const SizedBox(
                                height: 30.0,
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

                              const SizedBox(
                                height: 30.0,
                              ),

                              ConditionalBuilder(
                                condition: state is! SocialRegisterLoadingState,
                                builder: (BuildContext context) => SizedBox(
                                  width: double.infinity,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      if(formKey.currentState?.validate() != null)
                                      {
                                        SocialRegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                                fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}