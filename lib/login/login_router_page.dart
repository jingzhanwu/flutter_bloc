import 'package:bloc_demo/bloc/bloc_event_state_builder.dart';
import 'package:bloc_demo/bloc/bloc_provider.dart';
import 'package:bloc_demo/home_page.dart';
import 'package:bloc_demo/login/login_bloc.dart';
import 'package:bloc_demo/login/login_event.dart';
import 'package:bloc_demo/login/login_page.dart';
import 'package:bloc_demo/login/login_state.dart';
import 'package:flutter/material.dart';

class LoginRouterPage extends StatefulWidget {
  @override
  _RouterPageState createState() {
    return new _RouterPageState();
  }
}

class _RouterPageState extends State<LoginRouterPage> {
  LoginState oldLoginState;

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    return BlocEventStateBuilder<AuthenticationEvent, LoginState>(
        bloc: bloc,
        builder: (context, state) {
          if (state != oldLoginState) {
            oldLoginState = state;
            if (state.isLogged) {
              _redirectToPage(context, HomePage());
            } else if (state.isLogging || state.hasFailed) {
              //do nothing
            } else {
              _redirectToPage(context, LoginPage());
            }
          }
          return Container();
        });
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///要导航的新页面
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);

      ///开始导航
      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/loginRouter'));
    });
  }
}
