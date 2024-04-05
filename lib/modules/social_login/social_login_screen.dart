import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/social_login/cubit/cubit.dart';
import 'package:social_app/modules/social_login/cubit/states.dart';
import 'package:social_app/modules/social_register/social_register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => SocialLoginCubit(),

      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(

        listener: (BuildContext context, state)
        {
          if(state is SocialLoginErrorState)
          {
            showFlutterToast(
              context: context,
              text: state.error,
              state: ToastStates.ERROR,
            );
          }

          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute (builder: (BuildContext context) => SocialLayout()),
                  (route) => false
              );
            });
          }

        },

        builder: (BuildContext context, Object? state)
        {
          SocialLoginCubit cubit = SocialLoginCubit.get(context);

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
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),

                        const Text(
                          'Sign In now to communicate with friends!',
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

                              ConditionalBuilder(
                                condition: state is! SocialLoginLoadingState,
                                builder: (BuildContext context) => SizedBox(
                                  width: double.infinity,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      if(formKey.currentState?.validate() != null)
                                      {
                                        SocialLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'SIGN IN',
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

                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children:
                          [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            TextButton(
                                onPressed: ()
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute (
                                      builder: (BuildContext context) => SocialRegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Sign Up')
                            )
                          ],
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
