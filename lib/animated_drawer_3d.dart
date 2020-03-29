import 'dart:math' as math;

import 'package:animated_drawer_3d/colors.dart';
import 'package:flutter/material.dart';

class AnimatedDrawer3D extends StatefulWidget {
  final Widget mainPage;
  final Widget secondPage;

  const AnimatedDrawer3D({Key key, this.mainPage, this.secondPage})
      : super(key: key);
  @override
  _AnimatedDrawer3DState createState() => _AnimatedDrawer3DState();
}

class _AnimatedDrawer3DState extends State<AnimatedDrawer3D>
    with SingleTickerProviderStateMixin {
  final double maxSlide = 300;
  AnimationController animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  void _onDragStart(DragStartDetails details) {
    _canBeDragged =
        animationController.isDismissed || animationController.isCompleted;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return Material(
              color: CustomColor.sceneColor,
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset:
                        Offset(maxSlide * (animationController.value - 1), 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                            math.pi / 2 * (1 - animationController.value)),
                      alignment: Alignment.centerRight,
                      child: widget.secondPage,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(maxSlide * animationController.value, 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-math.pi * animationController.value / 2),
                      alignment: Alignment.centerLeft,
                      child: widget.mainPage,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
