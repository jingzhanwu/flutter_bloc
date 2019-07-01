import 'package:bloc_demo/bloc/bloc_event_state.dart';
import 'package:bloc_demo/splash/application_init_event.dart';
import 'package:bloc_demo/splash/application_init_state.dart';

///
/// Bloc业务处理类
/// 负责具体的事件处理，新的state产生
/// 这这里可以具体处理一些业务上的逻辑等，比如网络请求，数据库查询等等
///
class ApplicationInitBloc
    extends BlocEventStateBase<ApplicationInitEvent, ApplicationInitState> {
  ApplicationInitBloc()
      : super(
          initialState: ApplicationInitState.notInitialized(),
        );

  ///
  /// 根据event类型，处理不同的state
  /// 最终产生一个新的State抛出，父类会将新的状态添加进Controller
  ///
  @override
  Stream<ApplicationInitState> eventHandler(
      ApplicationInitEvent event, ApplicationInitState currentState) async* {
    ///如果还没有初始化，则抛出一个not init 的state，StreamBuilder接收到后更新UI
    if (!currentState.isInited) {
      yield ApplicationInitState.notInitialized();
    }

    ///如果已经初始化开始，则将进度条进度state抛出，StreamBuilder接收到后更新UI
    if (event.type == ApplicationInitEventType.start) {
      for (int progress = 0; progress < 101; progress += 10) {
        await Future.delayed(const Duration(milliseconds: 300));
        print("进度：：$progress");
        yield ApplicationInitState.progressing(progress);
      }
    }

    ///如果已经停止，则抛出已经初始化过的state，StreamBuilder接收到后更新UI
    if (event.type == ApplicationInitEventType.stop) {
      yield ApplicationInitState.initialized();
    }
  }
}
