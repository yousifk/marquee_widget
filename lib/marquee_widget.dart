library marquee_widget;

import 'package:async/async.dart';
import 'package:flutter/material.dart';

enum DirectionMarguee { oneDirection, TwoDirection }

class Marquee extends StatefulWidget {
  final Widget child;
  final TextDirection textDirection;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  final DirectionMarguee directionMarguee;

  Marquee(
      {@required this.child,
      this.direction = Axis.horizontal,
      this.textDirection = TextDirection.ltr,
      this.animationDuration = const Duration(milliseconds: 5000),
      this.backDuration = const Duration(milliseconds: 5000),
      this.pauseDuration = const Duration(milliseconds: 2000),
      this.directionMarguee = DirectionMarguee.TwoDirection});

  @override
  State<StatefulWidget> createState() => MarqueeState();
}

class MarqueeState extends State<Marquee> {
  final ScrollController _scrollController = ScrollController();
  RestartableTimer _pauseTimer;

  scroll() async {
    if (_scrollController.hasClients) {
      final position = _scrollController.position;
      if (position.pixels == position.minScrollExtent) {
        await _scrollController.animateTo(position.maxScrollExtent,
            duration: widget.animationDuration, curve: Curves.easeIn);
      } else {
        switch (widget.directionMarguee) {
          case DirectionMarguee.oneDirection:
            _scrollController.jumpTo(
              position.minScrollExtent,
            );
            break;
          case DirectionMarguee.TwoDirection:
            await _scrollController.animateTo(0.0,
                duration: widget.backDuration, curve: Curves.easeOut);
            break;
        }
      }
    }

    _pauseTimer.reset();
  }

  @override
  void dispose() {
    super.dispose();
    if (_pauseTimer != null && _pauseTimer.isActive) {
      _pauseTimer.cancel();
    }
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pauseTimer = RestartableTimer(widget.pauseDuration, scroll);
    return Directionality(
      textDirection: widget.textDirection,
      child: SingleChildScrollView(
        child: widget.child,
        scrollDirection: widget.direction,
        controller: _scrollController,
      ),
    );
  }
}
