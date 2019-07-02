import 'package:bloc_demo/bloc/bloc_event_state.dart';

///
/// 用户身份验证event
///
abstract class AuthenticationEvent extends BlocEvent {
  String name;

  AuthenticationEvent({this.name: ""});
}

///
/// 登录event
///
class LoginEvent extends AuthenticationEvent {
  LoginEvent({String name}) : super(name: name);
}

///
///登出event
///
class LogoutEvent extends AuthenticationEvent {
  LogoutEvent({String name}) : super(name: name);
}
