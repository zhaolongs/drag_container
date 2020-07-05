import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/7/5.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */


///抽屉状态监听
typedef OpenDragListener = void Function(int value);
///抽屉控制器
class DragController {

  OpenDragListener _openDragListener;
  ///控制器中添加监听
  setOpenDragListener(OpenDragListener listener) {
    _openDragListener = listener;
  }

  ///打开抽屉
  void open() {
    if (_openDragListener != null) {
      _openDragListener(1);
    }
  }
  ///关闭抽屉
  void close() {
    if (_openDragListener != null) {
      _openDragListener(2);
    }
  }
}