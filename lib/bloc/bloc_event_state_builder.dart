import 'package:flutter/material.dart';

import 'package:bloc_demo/bloc/bloc_event_state.dart';

typedef Widget AsyncBlocEventStateBuilder<BlocState>(
    BuildContext context, BlocState state);

///
/// StreamBuilder的实现,直接使用在界面中
///
/// 1、对EventState的State进行监听，一旦State有add操作，这里就会收到对应add的State
/// 2、返回Widget，这个Widget将使用bloc中的state；
/// 3、根据State对UI进行更新
///
class BlocEventStateBuilder<BlocEvent, BlocState> extends StatelessWidget {

  const BlocEventStateBuilder(
      {Key key, @required this.builder, @required this.bloc})
      : assert(builder != null),
        assert(bloc != null),
        super(key: key);

  ///事件状态管理实例
  final BlocEventStateBase<BlocEvent, BlocState> bloc;

  ///引用层要实现的视图构建方法
  final AsyncBlocEventStateBuilder<BlocState> builder;

  @override
  Widget build(BuildContext context) {
    ///StreamBuilder 这里监听BlocState的Stream
    return StreamBuilder<BlocState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
        return builder(context, snapshot.data);
      },
    );
  }
}
