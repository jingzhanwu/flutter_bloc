import 'package:bloc_demo/bloc/bloc_provider.dart';
import 'package:bloc_demo/login/login_bloc.dart';
import 'package:bloc_demo/login/login_page.dart';
import 'package:bloc_demo/login/login_router_page.dart';
import 'package:bloc_demo/splash/application_init_bloc.dart';
import 'package:bloc_demo/splash/application_init_event.dart';
import 'package:bloc_demo/splash/application_init_state.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_event_state_builder.dart';

void main() => runApp(BlocProvider<LoginBloc>(
    bloc: LoginBloc(),
    child: MaterialApp(
      title: 'Bloc demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {"/loginRouter": (context) => LoginRouterPage()},
      home: InitPage(),
    )));

///
/// 模拟应用程序的启动页面
///
class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() {
    return _InitPageState();
  }
}

class _InitPageState extends State<InitPage> {
  ApplicationInitBloc bloc;

  @override
  void initState() {
    super.initState();

    ///初始化bloc
    bloc = ApplicationInitBloc();

    ///发射一个event,这时EventStateBase中的eventController监听就会收到此event，
    ///并进行对应处理
    bloc.emitEvent(ApplicationInitEvent());
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            BlocEventStateBuilder<ApplicationInitEvent, ApplicationInitState>(
          bloc: bloc,
          builder: (BuildContext context, ApplicationInitState state) {
            if (state.isInited) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ///跳转到登录页面
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              });
            }
            return Text('Init in progress...${state.progress}%');
          },
        ),
      ),
    );
  }
}
