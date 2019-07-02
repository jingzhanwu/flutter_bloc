import 'package:bloc_demo/bloc/bloc_base.dart';
import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

///
/// 优化版Bloc provider类，管理bloc
///
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  ///
  /// 查找符合类型的Bloc，我们调用 InheritedWidget 的实例方法 context.ancestorInheritedElementForWidgetOfExactType()，
  /// 而这个方法的时间复杂度是 O(1)，意味着几乎可以立即查找到满足条件的 ancestor
  /// 查找复杂度底的原因源于 Fluter Framework 缓存了所有 InheritedWidgets 才得以实现。
  ///
  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();

    ///
    ///为什么要用 ancestorInheritedElementForWidgetOfExactType 而不用 inheritFromWidgetOfExactType ?
    ///因为 inheritFromWidgetOfExactType 不仅查找获取符合指定类型的Widget，还将context 注册到该Widget，
    ///以便Widget发生变动后，context可以获取到新值；这并不是我们想要的，我们想要的仅仅就是符合指定类型的Widget(也就是 BlocProvider)而已。
    ///
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
