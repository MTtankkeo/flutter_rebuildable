# Introduction
This package that provides widgets to help rebuild all descendant widgets or all widgets in the entire application.

> __When is it commonly used?__<br>
> It can be very useful when user-defined settings, such as themes, change and need to be reflected throughout the entire application.

## Usage
The following explains the basic usage of this package.

### Context-Based Rebuilding
Using `Rebuildable.of(context)`, you can rebuild only the widgets that are descendants of the given context. This is useful when you need to update a specific portion of your app without affecting the entire widget tree.

```dart
Rebuildable.of("context").rebuild();
```

### Global Rebuilding
If you need to rebuild all widgets in the application, you can use `RebuildableApp`. Wrapping your app with `RebuildableApp` allows you to trigger a full rebuild whenever necessary.

```dart
RebuildableApp(
    child: Text("Hello, World!")
);

RebuildableApp.rebuild();
```