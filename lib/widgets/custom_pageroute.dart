import 'package:flutter/cupertino.dart';

class CustomPageRoute extends PageRouteBuilder{


  final Widget child;
  final int num;

  CustomPageRoute({required this.child,required this.num}) : super(
    transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: ( context,animation,secondaryAnimation)=>child);


  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation,Widget child) => SlideTransition(
      position: Tween<Offset>(
        begin: num==0 ? Offset(-1,0) : Offset(1,0),
            end: Offset.zero
      ).animate(animation),
      child: child,
    );
}