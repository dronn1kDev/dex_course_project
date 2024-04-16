part of 'view_model.dart';

abstract class BaseView<VM extends ViewModel> extends Widget {
  final VM Function(BuildContext context) vmFactory;

  const BaseView({
    super.key,
    required this.vmFactory,
  });

  @override
  ViewElement<VM> createElement() => ViewElement<VM>(this);

  Widget build(BuildContext context, VM vm);
}

class ViewElement<VM extends ViewModel> extends ComponentElement {
  ViewElement(BaseView<VM> super.view);

  BaseView<VM> get view => widget as BaseView<VM>;

  VM? _vm;
  VM get vm => _vm!;

  @override
  Widget build() {
    return view.build(this, vm);
  }

  @override
  void update(covariant BaseView<VM> newWidget) {
    log('$runtimeType of ${newWidget.runtimeType} update');
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    _vm ??= view.vmFactory(this);
    vm.initState(this);
    super.mount(parent, newSlot);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vm.didChangeDependencies();
  }

  @override
  void activate() {
    super.activate();
    vm.activate();
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
    vm.dispose();
  }

  @override
  void reassemble() {
    vm.reassemble();
    super.reassemble();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<ViewModel>('view model', vm));
    super.debugFillProperties(properties);
  }
}
