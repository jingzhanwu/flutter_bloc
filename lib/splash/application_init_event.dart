
import 'package:bloc_demo/bloc/bloc_event_state.dart';

///
/// 定义BLoc事件
/// 代表Bloc的一个事件类，也可以对这个事件进行扩展，形成多个不同的事件
/// 如 登录事件，登出事件；他们得基类都是同一个
///
class ApplicationInitEvent extends BlocEvent {
  ///事件类型
  final ApplicationInitEventType type;

  ApplicationInitEvent({this.type: ApplicationInitEventType.start})
      : assert(type != null);
}

///
///定义事件类型枚举
///
enum ApplicationInitEventType { start, stop }
