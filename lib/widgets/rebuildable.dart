import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rebuildable/widgets/rebuildable_app.dart';

/// The widget that helps in context rebuild a descendant widgets all.
class Rebuildable extends StatefulWidget {
  const Rebuildable({
    super.key,
    required this.child
  });

  /// The [child] contained by the [Rebuildable] widget.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Finds the [RebuildableState] from the closest instance of this class
  /// that encloses the given context.
  ///
  /// If no instance of this class encloses the given context, will return null.
  /// To throw an exception instead, use [of] instead of this function.
  static RebuildableState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<RebuildableState>();
  }

  /// Finds the [RebuildableState] from the closest instance of this class
  /// that encloses the given context.
  static RebuildableState of(BuildContext context) {
    final RebuildableState? result = context.findAncestorStateOfType<RebuildableState>();
    assert(result != null, "The result is null. Consider calling the maybeOf function.");
    return result!;
  }

  @override
  State<Rebuildable> createState() => RebuildableState();
}

class RebuildableState extends State<Rebuildable> {
  /// Marks all child widgets in the given context as widgets
  /// that need to be rebuilt in the post next frame.
  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  /// Rebuilds all child widgets in this widget.
  void rebuild() {
    final isFrameRendering = WidgetsBinding.instance.schedulerPhase != SchedulerPhase.idle;

    // When the post next frame is already scheduled.
    if (isFrameRendering) {
      setState(() => rebuildAllChildren(context));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => rebuildAllChildren(context));
      });
    }
  }

  @override
  void initState() {
    super.initState();

    RebuildableApp.maybeOf(context)?.callbacks.add(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}