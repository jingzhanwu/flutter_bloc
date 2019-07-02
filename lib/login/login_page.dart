import 'package:bloc_demo/bloc/bloc_event_state_builder.dart';
import 'package:bloc_demo/bloc/bloc_provider.dart';
import 'package:bloc_demo/login/login_bloc.dart';
import 'package:bloc_demo/login/login_event.dart';
import 'package:bloc_demo/login/login_state.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  Future<bool> _onWillPopScope() async {
    return false;
  }

  LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    if (bloc == null) {
      bloc = BlocProvider.of<LoginBloc>(context);
    }
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Login'),
            leading: Container(),
          ),
          body: Container(
            child: BlocEventStateBuilder<AuthenticationEvent, LoginState>(
              bloc: bloc,
              builder: (BuildContext context, LoginState state) {
                ///正在登录
                if (state.isLogging) {
                  return CircularProgressIndicator();
                }

                ///已经登录
                if (state.isLogged) {
                  return Container();
                }

                List<Widget> children = <Widget>[];

                // Button to fake the authentication (success)
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text("登录"),
                      onPressed: () {
                        bloc.emitEvent(LoginEvent(name: 'login'));
                      },
                    ),
                  ),
                );

                // Button to fake the authentication (failure)
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text("登录失败，重新登录"),
                      onPressed: () {
                        bloc.emitEvent(LoginEvent(name: "failed"));
                      },
                    ),
                  ),
                );

                // Display a text if the authentication failed
                if (state.hasFailed) {
                  children.add(
                    Text("登录失败..."),
                  );
                }

                return Column(
                  children: children,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
