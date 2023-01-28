library marquee_widget;

import 'package:flutter/material.dart';

enum MarqueeDirection { forward, backward, forwardAndBackward }

class Marquee extends StatefulWidget {
  final Widget child;
  final MarqueeDirection marqueeDirection;
  final Axis direction;
  final TextDirection textDirection;
  final Curve forwardAnimation;
  final Curve backwardAnimation;
  final Duration forwardAnimationDuration;
  final Duration backwardAnimationDuration;
  final Duration animationGapDuration;
  final bool autoRepeat;

  const Marquee({
    Key? key,
    required this.child,
    this.marqueeDirection = MarqueeDirection.forwardAndBackward,
    this.direction = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
    this.forwardAnimation = Curves.easeIn,
    this.backwardAnimation = Curves.easeOut,
    this.forwardAnimationDuration = const Duration(milliseconds: 5000),
    this.backwardAnimationDuration = const Duration(milliseconds: 5000),
    this.animationGapDuration = const Duration(milliseconds: 2000),
    this.autoRepeat = true,
  }) : super(key: key);

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  final ScrollController _scrollController = ScrollController();

  void _animate() async {
    switch (widget.marqueeDirection) {
      case MarqueeDirection.forward:
        _playForwardAnimation();
        break;
      case MarqueeDirection.backward:
        _playBackwardAnimation();
        break;
      case MarqueeDirection.forwardAndBackward:
        _playForwardAndBackwardAnimation();
        break;
    }
  }

  Future<void> _playForwardAnimation() async {
    _setPositionToStart();

    await _animateForward();

    if (widget.autoRepeat) {
      await Future.delayed(widget.animationGapDuration);
      await _playForwardAnimation();
    }
  }

  Future<void> _playBackwardAnimation() async {
    _setPositionToEnd();

    await _animateBackward();

    if (widget.autoRepeat) {
      await Future.delayed(widget.animationGapDuration);
      await _playBackwardAnimation();
    }
  }

  Future<void> _playForwardAndBackwardAnimation() async {
    _setPositionToStart();

    await _animateForward();

    await Future.delayed(widget.animationGapDuration);

    await _animateBackward();

    if (widget.autoRepeat) {
      await Future.delayed(widget.animationGapDuration);
      await _playForwardAndBackwardAnimation();
    }
  }

  Future<void> _animateForward() async {
    return await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: widget.forwardAnimation,
      duration: widget.forwardAnimationDuration,
    );
  }

  Future<void> _animateBackward() async {
    return await _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      curve: widget.backwardAnimation,
      duration: widget.backwardAnimationDuration,
    );
  }

  void _setPositionToStart() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void _setPositionToEnd() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animate();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: widget.direction,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
