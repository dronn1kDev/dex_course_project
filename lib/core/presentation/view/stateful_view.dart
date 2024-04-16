part of 'view_model.dart';

abstract class StatefulView<VM extends ViewModel> extends Widget {
  final VM vm;

  const StatefulView({
    super.key,
    required this.vm,
  });

  @override
  StatefulViewElement createElement() => StatefulViewElement(this);

  ViewState<StatefulView<VM>, VM> createState();
}

class StatefulViewElement<VM extends ViewModel> extends ComponentElement {
  /// Creates an element that uses the given widget as its configuration.
  StatefulViewElement(StatefulView<VM> view)
      : _state = view.createState(),
        super(view) {
    assert(() {
      if (!state._debugTypesAreRight(view)) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              'StatefulWidget.createState must return a subtype of State<${view.runtimeType}>'),
          ErrorDescription(
            'The createState function for ${view.runtimeType} returned a state '
            'of type ${state.runtimeType}, which is not a subtype of '
            'State<${view.runtimeType}>, violating the contract for createState.',
          ),
        ]);
      }
      return true;
    }());
    assert(state._element == null);
    state._element = this;
    assert(
      state._widget == null,
      'The createState function for $view returned an old or invalid state '
      'instance: ${state._widget}, which is not null, violating the contract '
      'for createState.',
    );
    state._widget = view;
    assert(state._debugLifecycleState == _ViewStateLifecycle.created);
  }

  @override
  Widget build() => state.build(this);

  /// The [State] instance associated with this location in the tree.
  ///
  /// There is a one-to-one relationship between [State] objects and the
  /// [StatefulElement] objects that hold them. The [State] objects are created
  /// by [StatefulElement] in [mount].
  ViewState<StatefulView<VM>, VM> get state => _state!;
  ViewState<StatefulView<VM>, VM>? _state;
  VM get vm => state._view.vm;

  @override
  void reassemble() {
    vm.reassemble();
    super.reassemble();
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    _firstBuild();
    state._vm = vm;
    super.mount(parent, newSlot);
  }

  void _firstBuild() {
    assert(state._debugLifecycleState == _ViewStateLifecycle.created);
    final Object? debugCheckForReturnedFuture = vm.initState(this) as dynamic;
    assert(() {
      if (debugCheckForReturnedFuture is Future) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('${vm.runtimeType}.initState() returned a Future.'),
          ErrorDescription(
              'ViewModel.initState() must be a void method without an `async` keyword.'),
          ErrorHint(
            'Rather than awaiting on asynchronous work directly inside of initState, '
            'call a separate method to do this work without awaiting it.',
          ),
        ]);
      }
      return true;
    }());
    _state?._initState();
    assert(() {
      state._debugLifecycleState = _ViewStateLifecycle.initialized;
      return true;
    }());
    vm.didChangeDependencies();
    assert(() {
      state._debugLifecycleState = _ViewStateLifecycle.ready;
      return true;
    }());
  }

  @override
  void performRebuild() {
    if (_didChangeDependencies) {
      vm.didChangeDependencies();
      _didChangeDependencies = false;
    }
    super.performRebuild();
  }

  @override
  void update(StatefulView<VM> newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    final StatefulView<VM> oldWidget = state._widget!;
    state._widget = widget as StatefulView<VM>;
    final Object? debugCheckForReturnedFuture =
        state.didUpdateWidget(oldWidget) as dynamic;
    assert(() {
      if (debugCheckForReturnedFuture is Future) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              '${state.runtimeType}.didUpdateWidget() returned a Future.'),
          ErrorDescription(
              'State.didUpdateWidget() must be a void method without an `async` keyword.'),
          ErrorHint(
            'Rather than awaiting on asynchronous work directly inside of didUpdateWidget, '
            'call a separate method to do this work without awaiting it.',
          ),
        ]);
      }
      return true;
    }());
    rebuild(force: true);
  }

  @override
  void activate() {
    super.activate();
    vm.activate();
    // Since the State could have observed the deactivate() and thus disposed of
    // resources allocated in the build method, we have to rebuild the widget
    // so that its State can reallocate its resources.
    // assert(_lifecycleState == _ViewStateLifecycle.active); // otherwise markNeedsBuild is a no-op
    markNeedsBuild();
  }

  @override
  void deactivate() {
    vm.deactivate();
    super.deactivate();
  }

  @override
  void unmount() {
    super.unmount();
    state._dispose();
    vm.dispose();
    assert(() {
      if (state._debugLifecycleState == _ViewStateLifecycle.defunct) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('${vm.runtimeType}.dispose failed to call super.dispose.'),
        ErrorDescription(
          'dispose() implementations must always call their superclass dispose() method, to ensure '
          'that all the resources used by the widget are fully released.',
        ),
      ]);
    }());
    state._element = null;
    // Release resources to reduce the severity of memory leaks caused by
    // defunct, but accidentally retained Elements.
    _state = null;
  }

  @override
  InheritedWidget dependOnInheritedElement(Element ancestor, {Object? aspect}) {
    assert(() {
      final Type targetType = ancestor.widget.runtimeType;
      if (state._debugLifecycleState == _ViewStateLifecycle.created) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              'dependOnInheritedWidgetOfExactType<$targetType>() or dependOnInheritedElement() was called before ${state.runtimeType}.initState() completed.'),
          ErrorDescription(
            'When an inherited widget changes, for example if the value of Theme.of() changes, '
            "its dependent widgets are rebuilt. If the dependent widget's reference to "
            'the inherited widget is in a constructor or an initState() method, '
            'then the rebuilt dependent widget will not reflect the changes in the '
            'inherited widget.',
          ),
          ErrorHint(
            'Typically references to inherited widgets should occur in widget build() methods. Alternatively, '
            'initialization based on inherited widgets can be placed in the didChangeDependencies method, which '
            'is called after initState and whenever the dependencies change thereafter.',
          ),
        ]);
      }
      if (state._debugLifecycleState == _ViewStateLifecycle.defunct) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              'dependOnInheritedWidgetOfExactType<$targetType>() or dependOnInheritedElement() was called after dispose(): $this'),
          ErrorDescription(
            'This error happens if you call dependOnInheritedWidgetOfExactType() on the '
            'BuildContext for a widget that no longer appears in the widget tree '
            '(e.g., whose parent widget no longer includes the widget in its '
            'build). This error can occur when code calls '
            'dependOnInheritedWidgetOfExactType() from a timer or an animation callback.',
          ),
          ErrorHint(
            'The preferred solution is to cancel the timer or stop listening to the '
            'animation in the dispose() callback. Another solution is to check the '
            '"mounted" property of this object before calling '
            'dependOnInheritedWidgetOfExactType() to ensure the object is still in the '
            'tree.',
          ),
          ErrorHint(
            'This error might indicate a memory leak if '
            'dependOnInheritedWidgetOfExactType() is being called because another object '
            'is retaining a reference to this State object after it has been '
            'removed from the tree. To avoid memory leaks, consider breaking the '
            'reference to this object during dispose().',
          ),
        ]);
      }
      return true;
    }());
    return super
        .dependOnInheritedElement(ancestor as InheritedElement, aspect: aspect);
  }

  /// This controls whether we should call [State.didChangeDependencies] from
  /// the start of [build], to avoid calls when the [State] will not get built.
  /// This can happen when the widget has dropped out of the tree, but depends
  /// on an [InheritedWidget] that is still in the tree.
  ///
  /// It is set initially to false, since [_firstBuild] makes the initial call
  /// on the [state]. When it is true, [build] will call
  /// `state.didChangeDependencies` and then sets it to false. Subsequent calls
  /// to [didChangeDependencies] set it to true.
  bool _didChangeDependencies = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _didChangeDependencies = true;
    vm.didChangeDependencies();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ViewState<StatefulView<VM>, VM>>(
          'view state', _state,
          defaultValue: null))
      ..properties.add(DiagnosticsProperty<VM>('view model', vm));
  }
}

abstract class ViewState<T extends StatefulView<VM>, VM extends ViewModel>
    with Diagnosticable {
  /// The current configuration.
  ///
  /// A [State] object's configuration is the corresponding [StatefulWidget]
  /// instance. This property is initialized by the framework before calling
  /// [_initState]. If the parent updates this location in the tree to a new
  /// widget with the same [runtimeType] and [Widget.key] as the current
  /// configuration, the framework will update this property to refer to the new
  /// widget and then call [didUpdateWidget], passing the old configuration as
  /// an argument.
  T get _view => _widget!;
  T? _widget;

  VM? _vm;
  VM get vm => _vm!;

  /// The current stage in the lifecycle for this state object.
  ///
  /// This field is used by the framework when asserts are enabled to verify
  /// that [State] objects move through their lifecycle in an orderly fashion.
  _ViewStateLifecycle _debugLifecycleState = _ViewStateLifecycle.created;

  /// Verifies that the [State] that was created is one that expects to be
  /// created for that particular [Widget].
  bool _debugTypesAreRight(Widget widget) => widget is T;

  /// The location in the tree where this widget builds.
  ///
  /// The framework associates [State] objects with a [BuildContext] after
  /// creating them with [StatefulWidget.createState] and before calling
  /// [_initState]. The association is permanent: the [State] object will never
  /// change its [BuildContext]. However, the [BuildContext] itself can be moved
  /// around the tree.
  ///
  /// After calling [_dispose], the framework severs the [State] object's
  /// connection with the [BuildContext].
  BuildContext get context {
    assert(() {
      if (_element == null) {
        throw FlutterError(
          'This widget has been unmounted, so the State no longer has a context (and should be considered defunct). \n'
          'Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.',
        );
      }
      return true;
    }());
    return _element!;
  }

  StatefulViewElement? _element;

  /// Whether this [State] object is currently in a tree.
  ///
  /// After creating a [State] object and before calling [_initState], the
  /// framework "mounts" the [State] object by associating it with a
  /// [BuildContext]. The [State] object remains mounted until the framework
  /// calls [_dispose], after which time the framework will never ask the [State]
  /// object to [build] again.
  ///
  /// It is an error to call [setState] unless [mounted] is true.
  bool get mounted => _element != null;

  /// Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once for each [State] object
  /// it creates.
  ///
  /// Override this method to perform initialization that depends on the
  /// location at which this object was inserted into the tree (i.e., [context])
  /// or on the widget used to configure this object (i.e., [_view]).
  ///
  /// {@template flutter.widgets.State.initState}
  /// If a [State]'s [build] method depends on an object that can itself
  /// change state, for example a [ChangeNotifier] or [Stream], or some
  /// other object to which one can subscribe to receive notifications, then
  /// be sure to subscribe and unsubscribe properly in [_initState],
  /// [didUpdateWidget], and [dispose]:
  ///
  ///  * In [_initState], subscribe to the object.
  ///  * In [didUpdateWidget] unsubscribe from the old object and subscribe
  ///    to the new one if the updated widget configuration requires
  ///    replacing the object.
  ///  * In [_dispose], unsubscribe from the object.
  ///
  /// {@endtemplate}
  ///
  /// You should not use [BuildContext.dependOnInheritedWidgetOfExactType] from this
  /// method. However, [didChangeDependencies] will be called immediately
  /// following this method, and [BuildContext.dependOnInheritedWidgetOfExactType] can
  /// be used there.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.initState()`.
  @protected
  @mustCallSuper
  void _initState() {
    log('ViewState<${_view.runtimeType}> _initState');
    assert(_debugLifecycleState == _ViewStateLifecycle.created);
    if (kFlutterMemoryAllocationsEnabled) {
      FlutterMemoryAllocations.instance.dispatchObjectCreated(
        library: _flutterWidgetsLibrary,
        className: '$ViewState',
        object: this,
      );
    }
  }

  /// Called whenever the widget configuration changes.
  ///
  /// If the parent widget rebuilds and requests that this location in the tree
  /// update to display a new widget with the same [runtimeType] and
  /// [Widget.key], the framework will update the [_view] property of this
  /// [State] object to refer to the new widget and then call this method
  /// with the previous widget as an argument.
  ///
  /// Override this method to respond when the [_view] changes (e.g., to start
  /// implicit animations).
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which
  /// means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.didUpdateWidget(oldWidget)`.
  ///
  /// _See the discussion at [Element.rebuild] for more information on when this
  /// method is called._
  @mustCallSuper
  @protected
  void didUpdateWidget(covariant T oldWidget) {
    log('ViewState<${oldWidget.runtimeType}> didUpdateWidget');
  }

  /// {@macro flutter.widgets.Element.reassemble}
  ///
  /// In addition to this method being invoked, it is guaranteed that the
  /// [build] method will be invoked when a reassemble is signaled. Most
  /// widgets therefore do not need to do anything in the [reassemble] method.
  ///
  /// See also:
  ///
  ///  * [Element.reassemble]
  ///  * [BindingBase.reassembleApplication]
  ///  * [Image], which uses this to reload images.
  @protected
  @mustCallSuper
  // void reassemble() {}

  /// Called when this object is removed from the tree.
  ///
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree. In some cases, the framework will reinsert the [State]
  /// object into another part of the tree (e.g., if the subtree containing this
  /// [State] object is grafted from one location in the tree to another due to
  /// the use of a [GlobalKey]). If that happens, the framework will call
  /// [activate] to give the [State] object a chance to reacquire any resources
  /// that it released in [deactivate]. It will then also call [build] to give
  /// the [State] object a chance to adapt to its new location in the tree. If
  /// the framework does reinsert this subtree, it will do so before the end of
  /// the animation frame in which the subtree was removed from the tree. For
  /// this reason, [State] objects can defer releasing most resources until the
  /// framework calls their [dispose] method.
  ///
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.deactivate()`.
  ///
  /// See also:
  ///
  ///  * [dispose], which is called after [deactivate] if the widget is removed
  ///    from the tree permanently.
  @protected
  @mustCallSuper
  // void deactivate() {}

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  ///
  /// In most cases, after a [State] object has been deactivated, it is _not_
  /// reinserted into the tree, and its [dispose] method will be called to
  /// signal that it is ready to be garbage collected.
  ///
  /// In some cases, however, after a [State] object has been deactivated, the
  /// framework will reinsert it into another part of the tree (e.g., if the
  /// subtree containing this [State] object is grafted from one location in
  /// the tree to another due to the use of a [GlobalKey]). If that happens,
  /// the framework will call [activate] to give the [State] object a chance to
  /// reacquire any resources that it released in [deactivate]. It will then
  /// also call [build] to give the object a chance to adapt to its new
  /// location in the tree. If the framework does reinsert this subtree, it
  /// will do so before the end of the animation frame in which the subtree was
  /// removed from the tree. For this reason, [State] objects can defer
  /// releasing most resources until the framework calls their [dispose] method.
  ///
  /// The framework does not call this method the first time a [State] object
  /// is inserted into the tree. Instead, the framework calls [initState] in
  /// that situation.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  ///
  /// See also:
  ///
  ///  * [Element.activate], the corresponding method when an element
  ///    transitions from the "inactive" to the "active" lifecycle state.
  @protected
  @mustCallSuper
  // void activate() {}

  /// Called when this object is removed from the tree permanently.
  ///
  /// The framework calls this method when this [State] object will never
  /// build again. After the framework calls [_dispose], the [State] object is
  /// considered unmounted and the [mounted] property is false. It is an error
  /// to call [setState] at this point. This stage of the lifecycle is terminal:
  /// there is no way to remount a [State] object that has been disposed.
  ///
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.dispose()`.
  ///
  /// ## Caveats
  ///
  /// This method is _not_ invoked at times where a developer might otherwise
  /// expect it, such as application shutdown or dismissal via platform
  /// native methods.
  ///
  /// ### Application shutdown
  ///
  /// There is no way to predict when application shutdown will happen. For
  /// example, a user's battery could catch fire, or the user could drop the
  /// device into a swimming pool, or the operating system could unilaterally
  /// terminate the application process due to memory pressure.
  ///
  /// Applications are responsible for ensuring that they are well-behaved
  /// even in the face of a rapid unscheduled termination.
  ///
  /// To artificially cause the entire widget tree to be disposed, consider
  /// calling [runApp] with a widget such as [SizedBox.shrink].
  ///
  /// To listen for platform shutdown messages (and other lifecycle changes),
  /// consider the [AppLifecycleListener] API.
  ///
  /// ### Dismissing Flutter UI via platform native methods
  ///
  /// {@macro flutter.widgets.runApp.dismissal}
  ///
  /// See also:
  ///
  ///  * [deactivate], which is called prior to [_dispose].
  @protected
  @mustCallSuper
  void _dispose() {
    log('ViewState<${_view.runtimeType}> dispose');
    assert(_debugLifecycleState == _ViewStateLifecycle.ready);
    assert(() {
      _debugLifecycleState = _ViewStateLifecycle.defunct;
      return true;
    }());
    if (kFlutterMemoryAllocationsEnabled) {
      FlutterMemoryAllocations.instance.dispatchObjectDisposed(object: this);
    }
  }

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method in a number of different situations. For
  /// example:
  ///
  ///  * After calling [_initState].
  ///  * After calling [didUpdateWidget].
  ///  * After receiving a call to [setState].
  ///  * After a dependency of this [State] object changes (e.g., an
  ///    [InheritedWidget] referenced by the previous [build] changes).
  ///  * After calling [deactivate] and then reinserting the [State] object into
  ///    the tree at another location.
  ///
  /// This method can potentially be called in every frame and should not have
  /// any side effects beyond building a widget.
  ///
  /// The framework replaces the subtree below this widget with the widget
  /// returned by this method, either by updating the existing subtree or by
  /// removing the subtree and inflating a new subtree, depending on whether the
  /// widget returned by this method can update the root of the existing
  /// subtree, as determined by calling [Widget.canUpdate].
  ///
  /// Typically implementations return a newly created constellation of widgets
  /// that are configured with information from this widget's constructor, the
  /// given [BuildContext], and the internal state of this [State] object.
  ///
  /// The given [BuildContext] contains information about the location in the
  /// tree at which this widget is being built. For example, the context
  /// provides the set of inherited widgets for this location in the tree. The
  /// [BuildContext] argument is always the same as the [context] property of
  /// this [State] object and will remain the same for the lifetime of this
  /// object. The [BuildContext] argument is provided redundantly here so that
  /// this method matches the signature for a [WidgetBuilder].
  ///
  /// ## Design discussion
  ///
  /// ### Why is the [build] method on [State], and not [StatefulWidget]?
  ///
  /// Putting a `Widget build(BuildContext context)` method on [State] rather
  /// than putting a `Widget build(BuildContext context, State state)` method
  /// on [StatefulWidget] gives developers more flexibility when subclassing
  /// [StatefulWidget].
  ///
  /// For example, [AnimatedWidget] is a subclass of [StatefulWidget] that
  /// introduces an abstract `Widget build(BuildContext context)` method for its
  /// subclasses to implement. If [StatefulWidget] already had a [build] method
  /// that took a [State] argument, [AnimatedWidget] would be forced to provide
  /// its [State] object to subclasses even though its [State] object is an
  /// internal implementation detail of [AnimatedWidget].
  ///
  /// Conceptually, [StatelessWidget] could also be implemented as a subclass of
  /// [StatefulWidget] in a similar manner. If the [build] method were on
  /// [StatefulWidget] rather than [State], that would not be possible anymore.
  ///
  /// Putting the [build] function on [State] rather than [StatefulWidget] also
  /// helps avoid a category of bugs related to closures implicitly capturing
  /// `this`. If you defined a closure in a [build] function on a
  /// [StatefulWidget], that closure would implicitly capture `this`, which is
  /// the current widget instance, and would have the (immutable) fields of that
  /// instance in scope:
  ///
  /// ```dart
  /// // (this is not valid Flutter code)
  /// class MyButton extends StatefulWidgetX {
  ///   MyButton({super.key, required this.color});
  ///
  ///   final Color color;
  ///
  ///   @override
  ///   Widget build(BuildContext context, State state) {
  ///     return SpecialWidget(
  ///       handler: () { print('color: $color'); },
  ///     );
  ///   }
  /// }
  /// ```
  ///
  /// For example, suppose the parent builds `MyButton` with `color` being blue,
  /// the `$color` in the print function refers to blue, as expected. Now,
  /// suppose the parent rebuilds `MyButton` with green. The closure created by
  /// the first build still implicitly refers to the original widget and the
  /// `$color` still prints blue even through the widget has been updated to
  /// green; should that closure outlive its widget, it would print outdated
  /// information.
  ///
  /// In contrast, with the [build] function on the [State] object, closures
  /// created during [build] implicitly capture the [State] instance instead of
  /// the widget instance:
  ///
  /// ```dart
  /// class MyButton extends StatefulWidget {
  ///   const MyButton({super.key, this.color = Colors.teal});
  ///
  ///   final Color color;
  ///   // ...
  /// }
  ///
  /// class MyButtonState extends State<MyButton> {
  ///   // ...
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return SpecialWidget(
  ///       handler: () { print('color: ${widget.color}'); },
  ///     );
  ///   }
  /// }
  /// ```
  ///
  /// Now when the parent rebuilds `MyButton` with green, the closure created by
  /// the first build still refers to [State] object, which is preserved across
  /// rebuilds, but the framework has updated that [State] object's [_view]
  /// property to refer to the new `MyButton` instance and `${widget.color}`
  /// prints green, as expected.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget], which contains the discussion on performance considerations.
  @protected
  Widget build(BuildContext context);

  /// Called when a dependency of this [State] object changes.
  ///
  /// For example, if the previous call to [build] referenced an
  /// [InheritedWidget] that later changed, the framework would call this
  /// method to notify this object about the change.
  ///
  /// This method is also called immediately after [_initState]. It is safe to
  /// call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.
  ///
  /// Subclasses rarely override this method because the framework always
  /// calls [build] after a dependency changes. Some subclasses do override
  /// this method because they need to do some expensive work (e.g., network
  /// fetches) when their dependencies change, and that work would be too
  /// expensive to do for every build.
  // @protected
  // @mustCallSuper
  // void didChangeDependencies() {
  //   log('ViewState<${view.runtimeType}> didChangeDependencies');
  // }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    assert(() {
      properties.add(EnumProperty<_ViewStateLifecycle>(
          'lifecycle view state', _debugLifecycleState,
          defaultValue: _ViewStateLifecycle.ready));
      return true;
    }());
    properties
        .add(ObjectFlagProperty<T>('_widget', _widget, ifNull: 'no widget'));
    properties.add(ObjectFlagProperty<StatefulViewElement>('_element', _element,
        ifNull: 'not mounted'));
  }
}

/// Tracks the lifecycle of [State] objects when asserts are enabled.
enum _ViewStateLifecycle {
  /// The [State] object has been created. [State.initState] is called at this
  /// time.
  created,

  /// The [State.initState] method has been called but the [State] object is
  /// not yet ready to build. [State.didChangeDependencies] is called at this time.
  initialized,

  /// The [State] object is ready to build and [State.dispose] has not yet been
  /// called.
  ready,

  /// The [State.dispose] method has been called and the [State] object is
  /// no longer able to build.
  defunct,
}

const String _flutterWidgetsLibrary = 'package:flutter/widgets.dart';

mixin SingleTickerProviderViewStateMixin on ViewModel
    implements TickerProvider {
  Ticker? _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(() {
      if (_ticker == null) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            '$runtimeType is a SingleTickerProviderViewStateMixin but multiple tickers were created.'),
        ErrorDescription(
            'A SingleTickerProviderStateMixin can only be used as a TickerProvider once.'),
        ErrorHint(
          'If a State is used for multiple AnimationController objects, or if it is passed to other '
          'objects and those objects might use it more than one time in total, then instead of '
          'mixing in a SingleTickerProviderViewStateMixin, use a regular TickerProviderStateMixin.',
        ),
      ]);
    }());
    _ticker = Ticker(onTick,
        debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null);
    _updateTickerModeNotifier();
    _updateTicker(); // Sets _ticker.mute correctly.
    return _ticker!;
  }

  @override
  void dispose() {
    assert(() {
      if (_ticker == null || !_ticker!.isActive) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('$this was disposed with an active Ticker.'),
        ErrorDescription(
          '$runtimeType created a Ticker via its SingleTickerProviderViewStateMixin, but at the time '
          'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
          'be disposed before calling super.dispose().',
        ),
        ErrorHint(
          'Tickers used by AnimationControllers '
          'should be disposed by calling dispose() on the AnimationController itself. '
          'Otherwise, the ticker will leak.',
        ),
        _ticker!.describeForError('The offending ticker was'),
      ]);
    }());
    _tickerModeNotifier?.removeListener(_updateTicker);
    _tickerModeNotifier = null;
    super.dispose();
  }

  ValueListenable<bool>? _tickerModeNotifier;

  @override
  void activate() {
    super.activate();
    // We may have a new TickerMode ancestor.
    _updateTickerModeNotifier();
    _updateTicker();
  }

  void _updateTicker() {
    if (_ticker != null) {
      _ticker!.muted = !_tickerModeNotifier!.value;
    }
  }

  void _updateTickerModeNotifier() {
    final ValueListenable<bool> newNotifier = TickerMode.getNotifier(context);
    if (newNotifier == _tickerModeNotifier) {
      return;
    }
    _tickerModeNotifier?.removeListener(_updateTicker);
    newNotifier.addListener(_updateTicker);
    _tickerModeNotifier = newNotifier;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    String? tickerDescription;
    if (_ticker != null) {
      if (_ticker!.isActive && _ticker!.muted) {
        tickerDescription = 'active but muted';
      } else if (_ticker!.isActive) {
        tickerDescription = 'active';
      } else if (_ticker!.muted) {
        tickerDescription = 'inactive and muted';
      } else {
        tickerDescription = 'inactive';
      }
    }
    properties.add(DiagnosticsProperty<Ticker>('ticker', _ticker,
        description: tickerDescription,
        showSeparator: false,
        defaultValue: null));
  }
}
