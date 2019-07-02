
import 'package:bloc_demo/bloc/bloc_event_state.dart';
import 'package:meta/meta.dart';


///
/// 登录相关状态
///
class LoginState extends BlocState {
  ///名称，标签
  final String name;

  ///是否已经登录
  final bool isLogged;

  ///是否正在登录
  final bool isLogging;

  ///是否失败
  final bool hasFailed;

  LoginState(
      {this.name: "",
      @required this.isLogged,
      this.isLogging: false,
      this.hasFailed: false});

  ///初始化一个还没有登录的状态
  factory LoginState.notLogged() {
    return LoginState(isLogged: false);
  }

  ///返回一个已经登录的state
  factory LoginState.logged(String name) {
    return LoginState(isLogged: true, name: name);
  }

  ///返回一个正在登录的状态
  factory LoginState.logging() {
    return LoginState(isLogged: false, isLogging: true);
  }

  ///返回一个登录失败的状态
  factory LoginState.failed() {
    return LoginState(isLogged: false, hasFailed: true);
  }
}
