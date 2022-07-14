import 'package:flutter/gestures.dart';

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/7/5.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */

///lib/code15/drag/custom_recognizer.dart
///手势轻扫回调
typedef FilingListener = void Function(bool isFiling);

///垂直方向的手势识别
class CustomVerticalDragGestureRecognizer
    extends VerticalDragGestureRecognizer {
  ///轻扫监听
  final FilingListener filingListener;

  ///保存手势点的集合
  final Map<int, VelocityTracker> _velocityTrackers = <int, VelocityTracker>{};

  CustomVerticalDragGestureRecognizer(
      {Object? debugOwner, required this.filingListener})
      : super(debugOwner: debugOwner);

  @override
  void addPointer(PointerDownEvent event) {
    super.addPointer(event);

    _velocityTrackers[event.pointer] =
        VelocityTracker.withKind(PointerDeviceKind.touch);
  }

  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
    if (!event.synthesized &&
        (event is PointerDownEvent || event is PointerMoveEvent)) {
      ///主要用跟踪触摸屏事件（flinging事件和其他gestures手势事件）的速率
      final VelocityTracker? tracker = _velocityTrackers[event.pointer];
      assert(tracker != null);

      ///将指定时间的位置添加到跟踪器
      tracker!.addPosition(event.timeStamp, event.position);
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    final double minVelocity = minFlingVelocity ?? kMinFlingVelocity;
    final double minDistance = minFlingDistance ?? kTouchSlop;
    final VelocityTracker? tracker = _velocityTrackers[pointer];

    ///VelocityEstimate 计算二维速度的
    final VelocityEstimate? estimate = tracker?.getVelocityEstimate();
    bool isFling = false;
    if (estimate != null) {
      isFling = estimate.pixelsPerSecond.dy.abs() > minVelocity &&
          estimate.offset.dy.abs() > minDistance;
    }
    _velocityTrackers.clear();
    filingListener(isFling);

    ///super.didStopTrackingLastPointer(pointer) 会调用[_handleDragEnd]
    ///所以将[lingListener(isFling);]放在前一步调用
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void dispose() {
    _velocityTrackers.clear();
    super.dispose();
  }
}
