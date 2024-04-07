import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showFlutterToast({
  required context,
  required String text,
  required ToastStates state,
})
{

  showToast(
    text,
    borderRadius: BorderRadius.circular(10.0),
    context: context,
    animation: StyledToastAnimation.slideFromBottom,
    reverseAnimation: StyledToastAnimation.slideToBottom,
    position: StyledToastPosition.bottom,
    duration: const Duration(seconds: 5),
    animDuration: const Duration(milliseconds: 250),
    backgroundColor: chooseToastState(state: state),
    textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
  );



}

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastState({
  required ToastStates state,
})
{

  Color color;

  switch(state)
  {

    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
})
{
  return AppBar(
    leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.keyboard_arrow_left_outlined,
        size: 30.0,
      ),
    ),
    title: Text(
      title??'',
    ),
    titleSpacing: 5.0,
    actions: actions??[],
  );
}