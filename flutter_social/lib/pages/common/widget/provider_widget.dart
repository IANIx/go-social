import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EProviderLessWidget<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T model;
  final Widget? child;
  final Function(T)? onModelReady;

  EProviderLessWidget({
    Key? key,
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: builder,
        child: child,
      ),
    );
  }
}

///
/// 方便数据初始化
///
class EProviderWidget<T extends ChangeNotifier?> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T model;
  final Widget? child;
  final Function(T)? onModelReady;
  final bool value;

  EProviderWidget({
    Key? key,
    required this.builder,
    required this.model,
    this.value = false,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  EProviderWidget.value({
    Key? key,
    required this.builder,
    required this.model,
    this.value = true,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _EProviderWidgetState<T> createState() => _EProviderWidgetState<T>();
}

class _EProviderWidgetState<T extends ChangeNotifier?>
    extends State<EProviderWidget<T?>> {
  T? model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value) {
      return ChangeNotifierProvider<T?>.value(
        value: model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ),
      );
    }

    return ChangeNotifierProvider<T?>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class EProviderWidget2<A extends ChangeNotifier?, B extends ChangeNotifier?>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget? child)
      builder;
  final A model1;
  final B model2;
  final Widget? child;
  final Function(A, B)? onModelReady;

  EProviderWidget2({
    Key? key,
    required this.builder,
    required this.model1,
    required this.model2,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _EProviderWidgetState2<A, B> createState() => _EProviderWidgetState2<A, B>();
}

class _EProviderWidgetState2<A extends ChangeNotifier?,
    B extends ChangeNotifier?> extends State<EProviderWidget2<A?, B?>> {
  A? model1;
  B? model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model1, model2);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A?>(
            create: (context) => model1,
          ),
          ChangeNotifierProvider<B?>(
            create: (context) => model2,
          )
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
