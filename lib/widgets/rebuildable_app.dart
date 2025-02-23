import 'package:flutter/widgets.dart';
import 'package:flutter_rebuildable/widgets/rebuildable.dart';

/// The widget that helps globally rebuild widgets all of the application.
class RebuildableApp extends StatefulWidget {
  const RebuildableApp({
    super.key,
    required this.child
  });

  /// Rebuilds the widgets all of the application.
  static late final VoidCallback rebuild;

  /// The [child] contained by the [Rebuildable] widget.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Finds the [RebuildableAppState] from the closest instance of this class
  /// that encloses the given context.
  ///
  /// If no instance of this class encloses the given context, will return null.
  /// To throw an exception instead, use [of] instead of this function.
  static RebuildableAppState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<RebuildableAppState>();
  }

  /// Finds the [RebuildableState] from the closest instance of this class
  /// that encloses the given context.
  static RebuildableAppState of(BuildContext context) {
    final RebuildableAppState? result = context.findAncestorStateOfType<RebuildableAppState>();
    assert(result != null, "The result is null. Consider calling the maybeOf function.");
    return result!;
  }

  @override
  State<RebuildableApp> createState() => RebuildableAppState();
}

class RebuildableAppState extends State<RebuildableApp> {
  final callbacks = <VoidCallback>[];

  @override
  void initState() {
    super.initState();

    RebuildableApp.rebuild = () {
      for (var callback in callbacks) { callback.call(); }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Rebuildable(child: widget.child);
  }
}