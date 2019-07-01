import 'package:bloc_demo/bloc/bloc_event_state.dart';
import 'package:meta/meta.dart';

///
/// Bloc状态
/// 定义BlocEvent的状态，这里根据具体业务定义各个阶段的状态
///
class ApplicationInitState extends BlocState {
  ApplicationInitState(
      {@required this.isInited, this.isIniting, this.progress: 0});

  final bool isInited;
  final bool isIniting;
  final int progress;

  ///
  /// factory 构造器，构造一个没有开始初始化状态的实例
  ///
  factory ApplicationInitState.notInitialized() {
    return ApplicationInitState(isInited: false);
  }

  ///
  /// factory 构造器，构造一个正在初始化状态的实例
  ///
  factory ApplicationInitState.progressing(int progress) {
    return ApplicationInitState(
        isInited: progress == 100, isIniting: true, progress: progress);
  }

  ///
  /// factory 构造器，构造一个已经初始化完毕的状态的实例
  ///
  factory ApplicationInitState.initialized() {
    return ApplicationInitState(isInited: true, progress: 100);
  }
}
