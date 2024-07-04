import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomBouncingScrollPhysics extends ScrollPhysics {
  const BottomBouncingScrollPhysics({super.parent});

  @override
  BottomBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BottomBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  double frictionFactor(double overscrollFraction) =>
      0.52 * math.pow(1 - overscrollFraction, 2);

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0, 'Offset should not be zero');
    assert(
      position.minScrollExtent <= position.maxScrollExtent,
      'minScrollExtent should be less than or equal to maxScrollExtent',
    );

    if (!position.outOfRange) return offset;

    final double overscrollPastEnd =
        math.max(position.pixels - position.maxScrollExtent, 0);
    final overscrollPast = overscrollPastEnd;
    final easing = overscrollPastEnd > 0.0 && offset > 0.0;

    final friction = easing
        ? frictionFactor(
            (overscrollPast - offset.abs()) / position.viewportDimension,
          )
        : frictionFactor(overscrollPast / position.viewportDimension);
    final direction = offset.sign;

    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
    double extentOutside,
    double absDelta,
    double gamma,
  ) {
    assert(absDelta > 0, 'absDelta should be greater than zero');
    var total = 0;
    var newAbsDelta = absDelta;
    if (extentOutside > 0) {
      final deltaToLimit = extentOutside / gamma;
      if (newAbsDelta < deltaToLimit) return newAbsDelta * gamma;
      total += extentOutside.toInt();
      newAbsDelta -= deltaToLimit;
    }
    return total + newAbsDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    return 0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final tolerance =
        toleranceFor(position); // Use toleranceFor instead of tolerance
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  double get minFlingVelocity => kMinFlingVelocity * 2.0;

  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        math.min(
          0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(),
          40000.0,
        );
  }

  @override
  double get dragStartDistanceMotionThreshold => 3.5;
}
