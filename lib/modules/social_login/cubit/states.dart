abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class PasswordVisibilityState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {}

class SocialLoginErrorState extends SocialLoginStates
{
  final String error;

  SocialLoginErrorState(this.error);
}