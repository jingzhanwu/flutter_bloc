import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc_demo/bloc/bloc_base.dart';
import 'package:rxdart/rxdart.dart';


///
/// Bloc 事件的抽象类，定义一个事件
///
abstract class BlocEvent extends Object{

}

///
/// Bloc 状态抽象类，定义bloc的状态
///
abstract class BlocState extends Object {}


///
/// Bloc 事件状态管理的抽象类，
/// 1、接收事件event的输入
/// 2、当新的事件触发时，调用对应的事件处理器 eventHandler
/// 3、事件处理器 eventHandler 负责根据事件采用对应的处理action后，发出一个或者多个状态 state作为响应
///
abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  ///PublishSubject是一个普通广播StreamController，它返回Stream，有一种例外（当Stream返回的是Observable而不是Stream）
  ///仅向监听者（订阅者）发送在订阅之后产生的Stream事件
  PublishSubject<BlocEvent> _eventController = PublishSubject<BlocEvent>();

  ///BehaviorSubject是一个广播StreamController，但它返回的是Observable而不是Stream，与PublishSubject的不同
  ///是，它会将最后一次事件发送给订阅者（也就是监听者能接收到监听之前的最后一个事件）
  BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

  ///上层调用，产生(发布)一个事件，一般是在初始化创建BlocEvent时调用
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  ///获得state的stream,在BlocBuilder 中会监听这个State Stream;
  ///一旦这个State改变则对应UI会进行重绘(具体取决于上层逻辑)
  Stream<BlocState> get state => _stateController.stream;

  ///
  ///定义输入事件处理方法，根据输入事件与当前State进行业务处理
  ///相当于Java的抽象方法，具体处理逻辑右实现的子类实现。
  ///
  ///[event] :输入事件
  ///[currentState] :当前State，未处理本次event时的state
  ///
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  ///初始状态，一般在初始化bloc时指定
  final BlocState initialState;

  ///
  /// BlocEventState构造器，对Bloc进行初始化；Bloc初始化时主要做以下几件事：
  /// 1、开始监听事件Stream（eventController），因为event才是整个bloc处理的引擎;
  /// 2、接收到新的event时调用事件处理函数处理事件产生新State（也就是调用eventHandler方法）;
  ///   新状态将作为方法返回值返回（实际上也是一个State类型的Stream）；
  /// 3、对eventHandler返回结果进行遍历，将新的State添加到StateController中（发布一个State Stream）；
  ///
  /// 以上三步处理完毕之后，StreamBuilder就会接受到第 3 步最终添加的State,这时就可以根据新Sate进行UI
  /// 操作了。
  ///
  /// [initialState] :初始state，必选参数
  ///
  BlocEventStateBase({@required this.initialState}) {
    ///当事件状态管理器初始化时，就开始监听事件输入
    _eventController.stream.listen((BlocEvent event) {
      ///当有新的事件输入时开始处理状态
      BlocState currentState = _stateController.value ?? initialState;

      ///调用事件处理方法（子类具体实现处理），遍历结果state
      eventHandler(event, currentState).forEach((BlocState newState) {
        ///将新state加入stateController，StreamBuilder 会监听state
        _stateController.sink.add(newState);
      });
    });
  }

  ///
  /// 关闭两个StreamController
  ///
  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
