import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

part 'stateful_view.dart';
part 'view.dart';

abstract class ViewModel with Diagnosticable {
  BuildContext? _context;

  BuildContext get context {
    assert(() {
      if (!isMounted) {
        throw FlutterError('This widget has been unmounted');
      }
      return true;
    }());
    return _context!;
  }

  bool get isMounted => _context != null;

  @mustCallSuper
  void initState(BuildContext context) {
    log('ViewModel<$runtimeType> initState');
    _context = context;
  }

  /// Called when a dependency (by Build Context) of this View Model changes.
  ///
  /// For example, if View Model has reference on [InheritedWidget].
  /// This widget can change and method will called to notify about change.
  ///
  /// This method is also called immediately after [initState].
  @protected
  @visibleForTesting
  void didChangeDependencies() {
    log('ViewModel<$runtimeType> didChangeDependencies');
  }

  /// Called when this [ViewModel] and [BaseView] are removed from the tree.
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.deactivate()`.
  @protected
  @mustCallSuper
  @visibleForTesting
  void deactivate() {
    log('ViewModel<$runtimeType> deactivate');
  }

  /// Called when this [ViewModel] and [BaseView] are reinserted into
  /// the tree after having been removed via [deactivate].
  ///
  /// In most cases, after a [ViewModel] has been deactivated, it is not
  /// reinserted into the tree, and its [dispose] method will be called to
  /// signal that it is ready to be garbage collected.
  ///
  /// In some cases, however, after a [ViewModel] has been deactivated,
  /// it will reinserted it into another part of the tree (e.g., if there is a
  /// subtree uses a [GlobalKey] that match with key of the [BaseView]
  /// linked with this [ViewModel]).
  ///
  /// This method does not called the first time a WidgetModel object
  /// is inserted into the tree. Instead, calls [initState] in
  /// that situation.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  @protected
  @mustCallSuper
  @visibleForTesting
  void activate() {
    log('ViewModel<$runtimeType> activate');
  }

  /// Called when [BaseView] with this [ViewModel] is removed from the tree
  /// permanently.
  /// Should be used for preparation to be garbage collected.
  @protected
  @mustCallSuper
  @visibleForTesting
  void dispose() {
    log('ViewModel<$runtimeType> dispose');
    _context = null;
  }

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload. Most cases therefore do not need to do
  /// anything in the [reassemble] method.
  ///
  /// See also:
  ///  * [Element.reassemble]
  ///  * [BindingBase.reassembleApplication]
  @protected
  @mustCallSuper
  @visibleForTesting
  void reassemble() {
    log('ViewModel<$runtimeType> reassemble');
  }
}
