import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double _minFlingVelocity = 700.0;
const double _closeProgressThreshold = 0.5;

//For more infos:
//https://pub.dev/packages/flash

typedef FlashBuilder = Widget Function(
    BuildContext context, FlashController controller);

Future<T> showFlash<T>({
  @required BuildContext context,
  @required FlashBuilder builder,
  Duration duration,
  Duration transitionDuration = const Duration(milliseconds: 500),
  bool persistent = true,
  WillPopCallback onWillPop,
}) {
  return FlashController(
    context,
    builder,
    duration: duration,
    transitionDuration: transitionDuration,
    persistent: persistent,
    onWillPop: onWillPop,
  ).show();
}

class FlashController<T> {
  OverlayState overlay;
  final ModalRoute route;
  final BuildContext context;
  final FlashBuilder builder;

  /// How long until FlashMessage will hide itself (be dismissed). To make it indefinite, leave it null.
  final Duration duration;

  /// Use it to speed up or slow down the animation duration
  final Duration transitionDuration;

  /// Whether this FlashMessage is add to route.
  ///
  /// Must be non-null, defaults to `true`
  ///
  /// If `true` the FlashMessage will not add to route.
  ///
  /// If `false`, the FlashMessage will add to route as a [LocalHistoryEntry]. Typically the page is wrap with Overlay.
  ///
  /// This can be useful in situations where the app needs to dismiss the FlashMessage with [Navigator.pop].
  ///
  /// ```dart
  /// Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  ///   return Overlay(
  ///     initialEntries: [
  ///       OverlayEntry(builder: (context) {
  ///         return FlashPage();
  ///       }),
  ///     ],
  ///   );
  /// ```
  final bool persistent;

  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///
  /// If the callback returns a Future that resolves to false, the enclosing
  /// route will not be popped.
  final WillPopCallback onWillPop;

  /// The animation controller that the route uses to drive the transitions.
  ///
  /// The animation itself is exposed by the [animation] property.
  AnimationController get controller => _controller;
  AnimationController _controller;
  Timer _timer;
  LocalHistoryEntry _historyEntry;
  bool _dismissed = false;
  bool _removedHistoryEntry = false;

  FlashController(
    this.context,
    this.builder, {
    this.duration,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.persistent = true,
    this.onWillPop,
  })  : assert(context != null),
        assert(builder != null),
        assert(persistent != null),
        route = ModalRoute.of(context) {
    var rootOverlay = Navigator.of(context).overlay;
    if (persistent) {
      overlay = rootOverlay;
    } else {
      overlay = Overlay.of(context);
      assert(overlay != rootOverlay,
          'overlay can\'t be the root overlay when persistent is false');
    }
    assert(overlay != null);
    _controller = createAnimationController()
      ..addStatusListener(_handleStatusChanged);
  }

  /// A future that completes when this route is popped off the navigator.
  ///
  /// The future completes with the value given to [Navigator.pop], if any.
  Future<T> get popped => _transitionCompleter.future;
  final Completer<T> _transitionCompleter = Completer<T>();

  List<OverlayEntry> _overlayEntries;
  T _result;

  Future<T> show() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot show a $runtimeType after disposing it.');

    if (onWillPop != null) route?.addScopedWillPopCallback(onWillPop);
    overlay.insertAll(_overlayEntries = _createOverlayEntries());
    _controller.forward();
    _configureTimer();
    _configurePersistent();

    return popped;
  }

  /// Called to create the animation controller that will drive the transitions to
  /// this route from the previous one, and back to the previous route from this
  /// one.
  AnimationController createAnimationController() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    final Duration duration = transitionDuration;
    return AnimationController(
      duration: duration,
      debugLabel: debugLabel,
      vsync: overlay,
    );
  }

  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        if (_overlayEntries.isNotEmpty) _overlayEntries.first.opaque = false;
        break;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        if (_overlayEntries.isNotEmpty) _overlayEntries.first.opaque = false;
        break;
      case AnimationStatus.dismissed:
        // We might still be an active route if a subclass is controlling the
        // the transition and hits the dismissed status. For example, the iOS
        // back gesture drives this animation to the dismissed status before
        // removing the route and disposing it.
        dispose();
        break;
    }
  }

  List<OverlayEntry> _createOverlayEntries() {
    List<OverlayEntry> overlays = [];

    overlays.add(
      OverlayEntry(
          builder: (BuildContext context) {
            return builder(context, this);
          },
          maintainState: false,
          opaque: false),
    );

    return overlays;
  }

  void _configurePersistent() {
    if (!persistent) {
      _historyEntry = LocalHistoryEntry(onRemove: () {
        assert(!_transitionCompleter.isCompleted,
            'Cannot reuse a $runtimeType after disposing it.');
        _removedHistoryEntry = true;
        if (!_dismissed) {
          if (onWillPop != null) route?.removeScopedWillPopCallback(onWillPop);
          _cancelTimer();
          _controller.reverse();
        }
      });
      route?.addLocalHistoryEntry(_historyEntry);
    }
  }

  void _removeLocalHistory() {
    if (!persistent && !_removedHistoryEntry) {
      _historyEntry.remove();
      _removedHistoryEntry = true;
    }
  }

  void _configureTimer() {
    if (duration != null) {
      if (_timer?.isActive == true) {
        _timer.cancel();
      }
      _timer = Timer(duration, () {
        dismiss();
      });
    } else {
      _timer?.cancel();
    }
  }

  void _cancelTimer() {
    if (_timer?.isActive == true) {
      _timer.cancel();
    }
  }

  @protected
  void dismissInternal() {
    _dismissed = true;
    if (onWillPop != null) route?.removeScopedWillPopCallback(onWillPop);
    _removeLocalHistory();
    _cancelTimer();
  }

  void dismiss([T result]) {
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    _dismissed = true;
    _result = result;
    if (onWillPop != null) route?.removeScopedWillPopCallback(onWillPop);
    _removeLocalHistory();
    _cancelTimer();
    _controller.reverse();
  }

  @protected
  void dispose() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot dispose a $runtimeType twice.');
    dismissInternal();

    for (OverlayEntry entry in _overlayEntries) entry.remove();
    _overlayEntries.clear();
    _controller.dispose();
    _transitionCompleter.complete(_result);
  }

  /// A short description of this route useful for debugging.
  String get debugLabel => '$runtimeType';

  @override
  String toString() => '$runtimeType(animation: $_controller)';
}

/// A highly customizable widget so you can notify your user when you fell like he needs a beautiful explanation.
class FlashMessage<T extends Object> extends StatefulWidget {
  FlashMessage({
    Key key,
    @required this.controller,
    @required this.child,
    this.margin = EdgeInsets.zero,
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 1.0,
    this.brightness = Brightness.light,
    this.backgroundColor = Colors.white,
    this.boxShadows,
    this.backgroundGradient,
    this.onTap,
    this.enableDrag = true,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.fastOutSlowIn,
    this.alignment,
    this.position = FlashPosition.bottom,
    this.style = FlashStyle.floating,
    this.forwardAnimationCurve = Curves.fastOutSlowIn,
    this.reverseAnimationCurve = Curves.fastOutSlowIn,
    this.barrierBlur,
    this.barrierColor,
    this.barrierDismissible = true,
  })  : assert(controller != null),
        assert(child != null),
        assert(margin != null),
        assert(brightness != null),
        assert(style != null),
        assert(position != null),
        assert(() {
          if (alignment != null) return style == FlashStyle.floating;
          return true;
        }()),
        assert(barrierDismissible != null),
        super(key: key);

  final FlashController controller;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The brightness of the [backgroundColor] or [backgroundGradient]
  final Brightness brightness;

  /// Will be ignored if [backgroundGradient] is not null
  final Color backgroundColor;

  /// [boxShadows] The shadows generated by Flashbar. Leave it null if you don't want a shadow.
  /// You can use more than one if you feel the need.
  /// Check (this example)[https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/shadows.dart]
  final List<BoxShadow> boxShadows;

  /// Makes [backgroundColor] be ignored.
  final Gradient backgroundGradient;

  /// A callback that registers the user's click anywhere. An alternative to [primaryAction]
  final GestureTapCallback onTap;

  /// Determines if the user can swipe to dismiss the bar.
  /// It is recommended that you set [duration] != null if this is false.
  /// If the user swipes to dismiss no value will be returned.
  final bool enableDrag;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  /// Adds a custom margin to FlashMessage
  final EdgeInsets margin;

  /// Adds a radius to all corners of FlashMessage. Best combined with [margin].
  final BorderRadius borderRadius;

  /// Adds a border to every side of FlashMessage
  final Color borderColor;

  /// Changes the width of the border if [borderColor] is specified
  final double borderWidth;

  /// How to align the flash.
  final AlignmentGeometry alignment;

  /// FlashMessage can be based on [FlashPosition.top] or on [FlashPosition.center] or on [FlashPosition.bottom] of your screen.
  ///
  /// If [position] is not [FlashPosition.center], then the [alignment] has no effect.
  ///
  /// Default to [FlashPosition.bottom].
  final FlashPosition position;

  /// FlashMessage can be floating or be grounded to the edge of the screen.
  /// If [flashStyle] is grounded, I do not recommend using [margin] or [borderRadius].
  ///
  /// Default to [FlashStyle.floating].
  final FlashStyle style;

  /// The [Curve] animation used when show() is called. [Curves.fastOutSlowIn] is default
  final Curve forwardAnimationCurve;

  /// The [Curve] animation used when dismiss() is called. [Curves.fastOutSlowIn] is default
  final Curve reverseAnimationCurve;

  /// Only takes effect if [FlashController.persistent] is false.
  /// Creates a blurred overlay that prevents the user from interacting with the screen.
  /// The greater the value, the greater the blur.
  final double barrierBlur;

  /// Only takes effect if [FlashController.persistent] is false.
  /// Make sure you use a color with transparency here e.g. Colors.grey[600].withOpacity(0.2).
  final Color barrierColor;

  /// Only takes effect if [FlashController.persistent] is false, and [barrierBlur] or [barrierColor] is not null.
  /// Whether you can dismiss this flashbar by tapping the modal barrier.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  ///
  /// If [barrierDismissible] is true, then tapping this barrier will cause the
  /// current flashbar to be dismiss (see [FlashController.dismiss]) with null as the value.
  ///
  /// If [barrierDismissible] is false, then tapping the barrier has no effect.
  ///
  /// See also:
  ///
  ///  * [barrierBlur], which controls the blur of the scrim for this flashbar.
  ///  * [barrierColor], which controls the color of the scrim for this flashbar.
  final bool barrierDismissible;

  @override
  State createState() {
    return _FlashState<T>();
  }
}

class _FlashState<K extends Object> extends State<FlashMessage> {
  final GlobalKey _childKey = GlobalKey(debugLabel: 'flashbar child');

  double get _childHeight {
    final RenderBox renderBox = _childKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  FlashController get controller => widget.controller;

  AnimationController get animationController => controller.controller;

  Animation<double> _animation, _slideAnimation;

  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_handleStatusChanged);
    _slideAnimation = _animation = _createAnimation();
  }

  bool get _dismissUnderway =>
      animationController.status == AnimationStatus.reverse;

  bool _isDark() {
    return widget.brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (widget.borderRadius != null) {
      child = ClipRRect(
        borderRadius: widget.borderRadius,
        child: child,
      );
    }

    child = Ink(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        borderRadius: widget.borderRadius,
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor, width: widget.borderWidth)
            : null,
      ),
      child: child,
    );

    if (widget.onTap != null) {
      child = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: child,
      );
    }

    if (widget.style == FlashStyle.grounded) {
      child = SafeArea(
        bottom: widget.position == FlashPosition.bottom,
        top: widget.position == FlashPosition.top,
        child: child,
      );
    }

    child = Material(
      color: widget.backgroundColor,
      type: widget.style == FlashStyle.grounded
          ? MaterialType.canvas
          : MaterialType.transparency,
      child: child,
    );

    if (widget.position != FlashPosition.center) {
      child = AnnotatedRegion<SystemUiOverlayStyle>(
        value:
            _isDark() ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: child,
      );
    }

    if (widget.enableDrag) {
      child = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        child: child,
        excludeFromSemantics: true,
      );
    }

    child = DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: widget.boxShadows,
      ),
      child: child,
    );

    if (widget.style == FlashStyle.floating) {
      child = SafeArea(
        bottom: widget.position == FlashPosition.bottom,
        top: widget.position == FlashPosition.top,
        child: child,
      );
    }

    child = AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + widget.margin,
      duration: widget.insetAnimationDuration,
      curve: widget.insetAnimationCurve,
      child: child,
    );

    if (widget.position == FlashPosition.top) {
      child = SlideTransition(
        key: _childKey,
        position: _slideAnimation.drive(
            Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero)),
        child: child,
      );
    } else if (widget.position == FlashPosition.bottom) {
      child = SlideTransition(
        key: _childKey,
        position: _slideAnimation.drive(
            Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)),
        child: child,
      );
    } else {
      child = SlideTransition(
        key: _childKey,
        position: _slideAnimation.drive(
            Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero)),
        child: FadeTransition(
          opacity: _slideAnimation.drive(Tween<double>(begin: 0.0, end: 1.0)),
          child: child,
        ),
      );
    }

    var overlayBlur = widget.barrierBlur;
    var overlayColor = widget.barrierColor;
    child = Semantics(
      focused: false,
      scopesRoute: true,
      explicitChildNodes: true,
      child: Stack(
        children: <Widget>[
          // Aqui 1
          !controller.persistent &&
                  (overlayBlur != null || overlayColor != null)
              ? AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    var value = animationController.value;
                    overlayBlur ??= 0.0;
                    overlayColor ??= Colors.transparent;
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: widget.barrierDismissible
                          ? () => controller.dismiss()
                          : null,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: overlayBlur * value,
                          sigmaY: overlayBlur * value,
                        ),
                        child: Container(
                          constraints: BoxConstraints.expand(),
                          color: overlayColor
                              .withOpacity(overlayColor.opacity * value),
                        ),
                      ),
                    );
                  },
                )
              : Container(),
// Aqui 2
          widget.position == FlashPosition.center
              ? SafeArea(
                  child: Align(
                    alignment: widget.alignment ?? Alignment.center,
                    child: child,
                  ),
                )
              : Align(
                  alignment: widget.position == FlashPosition.bottom
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  child: child,
                ),
          // if (!controller.persistent &&
          //     (overlayBlur != null || overlayColor != null))
          //   AnimatedBuilder(
          //     animation: animationController,
          //     builder: (context, child) {
          //       var value = animationController.value;
          //       overlayBlur ??= 0.0;
          //       overlayColor ??= Colors.transparent;
          //       return GestureDetector(
          //         behavior: HitTestBehavior.translucent,
          //         onTap: widget.barrierDismissible
          //             ? () => controller.dismiss()
          //             : null,
          //         child: BackdropFilter(
          //           filter: ImageFilter.blur(
          //             sigmaX: overlayBlur * value,
          //             sigmaY: overlayBlur * value,
          //           ),
          //           child: Container(
          //             constraints: BoxConstraints.expand(),
          //             color: overlayColor
          //                 .withOpacity(overlayColor.opacity * value),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // if (widget.position == FlashPosition.center)
          //   SafeArea(
          //     child: Align(
          //       alignment: widget.alignment ?? Alignment.center,
          //       child: child,
          //     ),
          //   )
          // else
          //   Align(
          //     alignment: widget.position == FlashPosition.bottom
          //         ? Alignment.bottomCenter
          //         : Alignment.topCenter,
          //     child: child,
          //   ),
        ],
      ),
    );
    return child;
  }

  /// Called to create the animation that exposes the current progress of
  /// the transition controlled by the animation controller created by
  /// [FlashController.createAnimationController].
  Animation<double> _createAnimation() {
    assert(animationController != null);
    return CurvedAnimation(
      parent: animationController.view,
      curve: widget.forwardAnimationCurve,
      reverseCurve: widget.reverseAnimationCurve,
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    assert(widget.enableDrag);
    if (_dismissUnderway) return;
    _isDragging = true;
    if (widget.position == FlashPosition.top) {
      animationController.value +=
          details.primaryDelta / (_childHeight ?? details.primaryDelta);
    } else {
      animationController.value -=
          details.primaryDelta / (_childHeight ?? details.primaryDelta);
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    assert(widget.enableDrag);
    if (_dismissUnderway) return;
    _isDragging = false;
    if (animationController.status == AnimationStatus.completed) {
      setState(() => _slideAnimation = _animation);
    }
    if (widget.position == FlashPosition.top &&
        details.velocity.pixelsPerSecond.dy < -_minFlingVelocity) {
      final double flingVelocity =
          details.velocity.pixelsPerSecond.dy / _childHeight;
      if (animationController.value > 0.0) {
        animationController.fling(velocity: flingVelocity);
      }
      controller.dismissInternal();
    } else if ((widget.position == FlashPosition.center ||
            widget.position == FlashPosition.bottom) &&
        details.velocity.pixelsPerSecond.dy > _minFlingVelocity) {
      final double flingVelocity =
          -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (animationController.value > 0.0) {
        animationController.fling(velocity: flingVelocity);
      }
      controller.dismissInternal();
    } else if (animationController.value < _closeProgressThreshold) {
      if (animationController.value > 0.0)
        animationController.fling(velocity: -1.0);
      controller.dismissInternal();
    } else {
      animationController.forward();
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        if (!_isDragging) {
          setState(() => _slideAnimation = _animation);
        }
        break;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        if (_isDragging) {
          setState(() => _slideAnimation = animationController);
        }
        break;
      case AnimationStatus.dismissed:
        break;
    }
  }
}

/// Indicates if flash is going to start at the [top] or at the [center] or at the [bottom].
enum FlashPosition { top, center, bottom }

/// Indicates if flash will be attached to the edge of the screen or not
enum FlashStyle { floating, grounded }

class FlashBar extends StatefulWidget {
  FlashBar({
    Key key,
    this.padding = const EdgeInsets.all(16),
    this.title,
    this.message,
    this.icon,
    this.shouldIconPulse = true,
    this.leftBarIndicatorColor,
    this.primaryAction,
    this.actions,
    this.showProgressIndicator = false,
    this.progressIndicatorController,
    this.progressIndicatorBackgroundColor,
    this.progressIndicatorValueColor,
    this.userInputForm,
  })  : assert(showProgressIndicator != null),
        super(key: key);

  /// The (optional) title of the flashbar is displayed in a large font at the top
  /// of the flashbar.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// The message of the flashbar is displayed in the center of the flashbar in
  /// a lighter font.
  ///
  /// Typically a [Text] widget.
  final Widget message;

  /// If not null, shows a left vertical bar to better indicate the humor of the notification.
  /// It is not possible to use it with a [Form] and I do not recommend using it with [LinearProgressIndicator]
  final Color leftBarIndicatorColor;

  /// You can use any widget here, but I recommend [Icon] or [Image] as indication of what kind
  /// of message you are displaying. Other widgets may break the layout
  final Widget icon;

  /// An option to animate the icon (if present). Defaults to true.
  final bool shouldIconPulse;

  /// A widget if you need an action from the user.
  final Widget primaryAction;

  /// The (optional) set of actions that are displayed at the bottom of the flashbar.
  ///
  /// Typically this is a list of [FlatButton] widgets.
  ///
  /// These widgets will be wrapped in a [ButtonBar], which introduces 8 pixels
  /// of padding on each side.
  final List<Widget> actions;

  /// True if you want to show a [LinearProgressIndicator].
  final bool showProgressIndicator;

  /// An optional [AnimationController] when you want to control the progress of your [LinearProgressIndicator].
  final AnimationController progressIndicatorController;

  /// A [LinearProgressIndicator] configuration parameter.
  final Color progressIndicatorBackgroundColor;

  /// A [LinearProgressIndicator] configuration parameter.
  final Animation<Color> progressIndicatorValueColor;

  /// Adds a custom padding to Flashbar
  ///
  /// The default follows material design guide line
  final EdgeInsets padding;

  /// A [TextFormField] in case you want a simple user input. Every other widget is ignored if this is not null.
  final Form userInputForm;

  @override
  _FlashBarState createState() => _FlashBarState();
}

class _FlashBarState extends State<FlashBar>
    with SingleTickerProviderStateMixin {
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;

  final double _initialOpacity = 1.0;
  final double _finalOpacity = 0.4;

  final Duration _pulseAnimationDuration = Duration(seconds: 1);

  bool _isTitlePresent;
  double _messageTopMargin;

  FocusScopeNode _focusNode;
  FocusAttachment _focusAttachment;

  @override
  void initState() {
    super.initState();

    assert(widget.userInputForm != null || widget.message != null,
        "A message is mandatory if you are not using userInputForm. Set either a message or messageText");

    _isTitlePresent = (widget.title != null);
    _messageTopMargin = _isTitlePresent ? 6.0 : widget.padding.top;

    _configureProgressIndicatorAnimation();

    if (widget.icon != null && widget.shouldIconPulse) {
      _configurePulseAnimation();
      _fadeController?.forward();
    }

    _focusNode = FocusScopeNode();
    _focusAttachment = _focusNode.attach(context);
  }

  void _configureProgressIndicatorAnimation() {
    if (widget.showProgressIndicator &&
        widget.progressIndicatorController != null) {
      _progressAnimation = CurvedAnimation(
          curve: Curves.linear, parent: widget.progressIndicatorController);
    }
  }

  void _configurePulseAnimation() {
    _fadeController =
        AnimationController(vsync: this, duration: _pulseAnimationDuration);
    _fadeAnimation = Tween(begin: _initialOpacity, end: _finalOpacity).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.linear,
      ),
    );

    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _fadeController.forward();
      }
    });

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController?.dispose();

    widget.progressIndicatorController?.dispose();

    _focusAttachment.detach();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Aqui 3
        widget.showProgressIndicator
            ? LinearProgressIndicator(
                value: widget.progressIndicatorController != null
                    ? _progressAnimation.value
                    : null,
                backgroundColor: widget.progressIndicatorBackgroundColor,
                valueColor: widget.progressIndicatorValueColor,
              )
            : Container(),
        // if (widget.showProgressIndicator)
        //   LinearProgressIndicator(
        //     value: widget.progressIndicatorController != null
        //         ? _progressAnimation.value
        //         : null,
        //     backgroundColor: widget.progressIndicatorBackgroundColor,
        //     valueColor: widget.progressIndicatorValueColor,
        //   ),
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _getAppropriateRowLayout(),
          ),
        ),
      ],
    );
  }

  CurvedAnimation _progressAnimation;

  List<Widget> _getAppropriateRowLayout() {
    double buttonRightPadding;
    double iconPadding = 0;
    if (widget.padding.right - 12 < 0) {
      buttonRightPadding = 4;
    } else {
      buttonRightPadding = widget.padding.right - 12;
    }

    if (widget.padding.left > 16.0) {
      iconPadding = widget.padding.left;
    }

    if (widget.icon == null && widget.primaryAction == null) {
      return [
        // Aqui 4
        widget.leftBarIndicatorColor != null
            ? Container(
                color: widget.leftBarIndicatorColor,
                width: 5.0,
              )
            : Container(),
        // if (widget.leftBarIndicatorColor != null)
        //   Container(
        //     color: widget.leftBarIndicatorColor,
        //     width: 5.0,
        //   ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Aqui 5
              _isTitlePresent
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: widget.padding.left,
                        right: widget.padding.right,
                      ),
                      child: _getTitle(),
                    )
                  : Container(),
              // if (_isTitlePresent)
              //   Padding(
              //     padding: EdgeInsets.only(
              //       top: widget.padding.top,
              //       left: widget.padding.left,
              //       right: widget.padding.right,
              //     ),
              //     child: _getTitle(),
              //   ),
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: _getMessage(),
              ),
              // Aqui 6
              widget.actions != null
                  ? ButtonTheme.bar(
                      padding:
                          EdgeInsets.symmetric(horizontal: buttonRightPadding),
                      child: ButtonBar(
                        children: widget.actions,
                      ),
                    )
                  : Container(),
              // if (widget.actions != null)
              //   ButtonTheme.bar(
              //     padding: EdgeInsets.symmetric(horizontal: buttonRightPadding),
              //     child: ButtonBar(
              //       children: widget.actions,
              //     ),
              //   ),
            ],
          ),
        ),
      ];
    } else if (widget.icon != null && widget.primaryAction == null) {
      return <Widget>[
        // Aqui 7
        widget.leftBarIndicatorColor != null
            ? Container(
                color: widget.leftBarIndicatorColor,
                width: 5.0,
              )
            : Container(),
        // if (widget.leftBarIndicatorColor != null)
        //   Container(
        //     color: widget.leftBarIndicatorColor,
        //     width: 5.0,
        //   ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 42.0 + iconPadding),
                    child: _getIcon(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Aqui 8
                        _isTitlePresent
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: widget.padding.top,
                                  left: 4.0,
                                  right: widget.padding.left,
                                ),
                                child: _getTitle(),
                              )
                            : Container(),
                        // if (_isTitlePresent)
                        //   Padding(
                        //     padding: EdgeInsets.only(
                        //       top: widget.padding.top,
                        //       left: 4.0,
                        //       right: widget.padding.left,
                        //     ),
                        //     child: _getTitle(),
                        //   ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: _messageTopMargin,
                            left: 4.0,
                            right: widget.padding.right,
                            bottom: widget.padding.bottom,
                          ),
                          child: _getMessage(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Aqui 9
              widget.actions != null
                  ? ButtonTheme.bar(
                      padding:
                          EdgeInsets.symmetric(horizontal: buttonRightPadding),
                      child: ButtonBar(
                        children: widget.actions,
                      ),
                    )
                  : Container(),
              // if (widget.actions != null)
              //   ButtonTheme.bar(
              //     padding: EdgeInsets.symmetric(horizontal: buttonRightPadding),
              //     child: ButtonBar(
              //       children: widget.actions,
              //     ),
              //   ),
            ],
          ),
        ),
      ];
    } else if (widget.icon == null && widget.primaryAction != null) {
      return <Widget>[
        // Aqui 10
        widget.leftBarIndicatorColor != null
            ? Container(
                color: widget.leftBarIndicatorColor,
                width: 5.0,
              )
            : Container(),
        // if (widget.leftBarIndicatorColor != null)
        //   Container(
        //     color: widget.leftBarIndicatorColor,
        //     width: 5.0,
        //   ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Aqui 11
                        _isTitlePresent
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: widget.padding.top,
                                  left: widget.padding.left,
                                  right: widget.padding.right,
                                ),
                                child: _getTitle(),
                              )
                            : Container(),
                        // if (_isTitlePresent)
                        //   Padding(
                        //     padding: EdgeInsets.only(
                        //       top: widget.padding.top,
                        //       left: widget.padding.left,
                        //       right: widget.padding.right,
                        //     ),
                        //     child: _getTitle(),
                        //   ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: _messageTopMargin,
                            left: widget.padding.left,
                            right: 4.0,
                            bottom: widget.padding.bottom,
                          ),
                          child: _getMessage(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: buttonRightPadding),
                    child: _getPrimaryAction(),
                  ),
                ],
              ),
              // Aqui 12
              widget.actions != null
                  ? ButtonTheme.bar(
                      padding:
                          EdgeInsets.symmetric(horizontal: buttonRightPadding),
                      child: ButtonBar(
                        children: widget.actions,
                      ),
                    )
                  : Container(),
              // if (widget.actions != null)
              //   ButtonTheme.bar(
              //     padding: EdgeInsets.symmetric(horizontal: buttonRightPadding),
              //     child: ButtonBar(
              //       children: widget.actions,
              //     ),
              //   ),
            ],
          ),
        ),
      ];
    } else {
      return <Widget>[
        // Aqui 13
        widget.leftBarIndicatorColor != null
            ? Container(
                color: widget.leftBarIndicatorColor,
                width: 5.0,
              )
            : Container(),
        // if (widget.leftBarIndicatorColor != null)
        //   Container(
        //     color: widget.leftBarIndicatorColor,
        //     width: 5.0,
        //   ),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 42.0 + iconPadding),
                      child: _getIcon(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Aqui 14
                          _isTitlePresent
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: widget.padding.top,
                                    left: 4.0,
                                    right: 4.0,
                                  ),
                                  child: _getTitle(),
                                )
                              : Container(),
                          // if (_isTitlePresent)
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //     top: widget.padding.top,
                          //     left: 4.0,
                          //     right: 4.0,
                          //   ),
                          //   child: _getTitle(),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: _messageTopMargin,
                              left: 4.0,
                              right: 4.0,
                              bottom: widget.padding.bottom,
                            ),
                            child: _getMessage(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: buttonRightPadding),
                      child: _getPrimaryAction(),
                    ),
                  ],
                ),
              ),
              // Aqui 15
              widget.actions != null
                  ? ButtonTheme.bar(
                      padding:
                          EdgeInsets.symmetric(horizontal: buttonRightPadding),
                      child: ButtonBar(
                        children: widget.actions,
                      ),
                    )
                  : Container(),
              // if (widget.actions != null)
              //   ButtonTheme.bar(
              //     padding: EdgeInsets.symmetric(horizontal: buttonRightPadding),
              //     child: ButtonBar(
              //       children: widget.actions,
              //     ),
              //   ),
            ],
          ),
        ),
      ];
    }
  }

  Widget _getIcon() {
    assert(widget.icon != null);
    Widget child;
    if (widget.icon is Icon && widget.shouldIconPulse) {
      child = FadeTransition(
        opacity: _fadeAnimation,
        child: widget.icon,
      );
    } else {
      child = widget.icon;
    }
    var theme = Theme.of(context);
    var buttonTheme = ButtonTheme.of(context);
    return IconTheme(
      data: theme.iconTheme.copyWith(color: buttonTheme.colorScheme.primary),
      child: child,
    );
  }

  Widget _getTitle() {
    return Semantics(
      child: widget.title,
      namesRoute: true,
      container: true,
    );
  }

  Widget _getMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Aqui 16
        widget.message != null ? widget.message : Container(),
        // if (widget.message != null) widget.message,
        // Aqui 17
        widget.userInputForm != null
            ? FocusScope(
                child: widget.userInputForm,
                node: _focusNode,
                autofocus: true,
              )
            : Container(),
        // if (widget.userInputForm != null)
        //   FocusScope(
        //     child: widget.userInputForm,
        //     node: _focusNode,
        //     autofocus: true,
        //   ),
      ],
    );
  }

  Widget _getPrimaryAction() {
    assert(widget.primaryAction != null);
    var buttonTheme = ButtonTheme.of(context);
    return ButtonTheme(
      textTheme: ButtonTextTheme.primary,
      child: IconTheme(
        data: Theme.of(context)
            .iconTheme
            .copyWith(color: buttonTheme.colorScheme.primary),
        child: widget.primaryAction,
      ),
    );
  }
}
