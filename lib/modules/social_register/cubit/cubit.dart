import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{

  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  void changePasswordVisibility()
  {

    isPasswordVisible = !isPasswordVisible;

    emit(PasswordRegisterVisibilityState());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).then((value){

      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid
      );
      
    }).catchError((error){
      
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      cover: 'https://img.freepik.com/free-vector/young-man-with-blue-hair_24877-82124.jpg?w=740',
      image: 'https://img.freepik.com/free-vector/young-man-with-blue-hair_24877-82124.jpg?w=740',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap()).then((value){

        emit(SocialCreateUserSuccessState());

    }).catchError((error){

      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

}