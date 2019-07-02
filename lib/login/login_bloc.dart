import 'package:bloc_demo/bloc/bloc_event_state.dart';
import 'package:bloc_demo/login/login_event.dart';
import 'package:bloc_demo/login/login_state.dart';
import 'package:bloc_demo/login/user.dart';

///
/// 处理登录逻辑的Bloc类
///
class LoginBloc extends BlocEventStateBase<AuthenticationEvent, LoginState> {
  ///登录相关数据
  LoginData data;

  LoginBloc({this.data}) : super(initialState: LoginState.notLogged()) {
    if (data == null) {
      data = LoginData.initData();
    }
  }

  @override
  Stream<LoginState> eventHandler(
      AuthenticationEvent event, LoginState currentState) async* {
    ///登录事件
    if (event is LoginEvent) {
      ///发送一个登录的state
      yield LoginState.logging();

      ///处理登录逻辑
      User _user = await _loginServer();
      if (_user != null) {
        ///登录成功,保存用户数据
        data.user = _user;
        yield LoginState.logged(event.name);
      } else {
        ///登录失败
        yield LoginState.failed();
      }

      if (event.name == "failed") {
        ///登录失败，发送一个失败的state
        yield LoginState.failed();
      } else {
        ///登录成功，发送一个成功的state
        yield LoginState.logged(event.name);
      }
    }

    ///登出事件
    if (event is LogoutEvent) {
      ///登出，发送一个要登出的state
      yield LoginState.notLogged();
    }
  }

  ///
  /// 模拟登录
  ///
  Future<User> _loginServer() async {
    await Future.delayed(Duration(milliseconds: 3000));

    return null;
  }
}

///
///登录用户相关的数据
///
class LoginData {
  User user;

  LoginData({this.user});

  factory LoginData.initData() {
    return LoginData(user: User(name: "景占午", password: "123456"));
  }
}
