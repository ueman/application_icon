import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

class TiltableStack extends StatefulWidget {
  const TiltableStack({
    Key key,
    @required this.children,
    this.fit = StackFit.loose,
    this.onTap,
    this.alignment = Alignment.bottomCenter,
  })  : assert(children != null, 'children should not be null'),
        super(key: key);

  final List<Widget> children;
  final Alignment alignment;
  final GestureTapCallback onTap;
  final StackFit fit;

  @override
  _TiltableStackState createState() => _TiltableStackState();
}

class _TiltableStackState extends State<TiltableStack>
    with TickerProviderStateMixin {
  AnimationController tilt;
  AnimationController depth;
  double pitch = 0;
  double yaw = 0;
  Offset _offset;
  SpringSimulation springSimulation;

  @override
  void initState() {
    super.initState();
    tilt = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: 500),
      vsync: this,
      lowerBound: -2,
      upperBound: 2,
    )..addListener(() {
        if (_offset == null) {
          pitch *= tilt.value;
          yaw *= tilt.value;
          updateTransformation();
        }
      });
    depth = AnimationController(
      value: 0,
      duration: const Duration(milliseconds: 500),
      vsync: this,
      lowerBound: -2,
      upperBound: 2,
    )..addListener(updateTransformation);
  }

  @override
  void dispose() {
    tilt.dispose();
    depth.dispose();
    super.dispose();
  }

  void updateTransformation() {
    setState(() {});
  }

  final SpringDescription spring = const SpringDescription(
    mass: 1,
    stiffness: 400,
    damping: 6,
  );

  void cancelPan() {
    tilt.animateWith(SpringSimulation(spring, 1, 0, tilt.velocity));
    depth.animateWith(SpringSimulation(spring, depth.value, 0, depth.velocity));
    _offset = null;
  }

  void startPan() {
    depth.animateWith(SpringSimulation(spring, depth.value, 1, depth.velocity));
  }

  void updatePan(LongPressMoveUpdateDetails drag) {
    final size = MediaQuery.of(context).size;
    final offset = _globalToLocal(context, drag.globalPosition);
    _offset ??= offset;

    pitch += (offset.dy - _offset.dy) * (1 / size.height);
    yaw -= (offset.dx - _offset.dx) * (1 / size.width);
    _offset = offset;

    updateTransformation();
  }

  TickerFuture onTapDown() {
    return depth.animateWith(
      SpringSimulation(
        spring,
        depth.value,
        0,
        -5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPressMoveUpdate: updatePan,
      onLongPressStart: (_) => startPan(),
      onLongPressEnd: (_) => cancelPan(),
      onTapDown: (_) => onTapDown(),
      child: _TiltedStack(
        fit: widget.fit,
        data: _TransformationData(pitch, yaw, depth.value),
        alignment: widget.alignment,
        children: widget.children,
      ),
    );
  }

  Offset _globalToLocal(BuildContext context, Offset globalPosition) {
    final RenderBox box = context.findRenderObject();
    return box.globalToLocal(globalPosition);
  }
}

class _TransformationData {
  _TransformationData(this.pitch, this.yaw, this.depth);

  final double pitch;
  final double yaw;
  final double depth;
}

class _TiltedStack extends StatelessWidget {
  const _TiltedStack({
    Key key,
    @required this.children,
    @required this.data,
    this.alignment = Alignment.center,
    this.fit = StackFit.loose,
  }) : super(key: key);

  final _TransformationData data;
  final List<Widget> children;
  final AlignmentGeometry alignment;
  final StackFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: fit,
      alignment: alignment,
      children: [
        for (var i = 0; i < children.length; i++)
          Stack(
            alignment: alignment,
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(data.pitch)
                  ..rotateY(data.yaw)
                  ..translate(-data.yaw * i * 70, data.pitch * i * 70, 0)
                  ..scale((data.depth ?? 0) * (i + 1) * 0.1 + 1),
                child: children[i],
                alignment: FractionalOffset.center,
              ),
            ],
          ),
      ],
    );
  }
}
