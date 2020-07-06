import 'package:drag_container/drag/drag_container.dart';
import 'package:drag_container/drag/drag_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/7/6.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */

///上拉抽屉效果
class BottomDragWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomDragWidgetState();
  }
}

class BottomDragWidgetState extends State {
  ///滑动控制器
  ScrollController scrollController = new ScrollController();

  ///抽屉控制器
  DragController dragController = new DragController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("抽屉效果"),
      ),
      backgroundColor: Colors.grey,

      ///页面主体使用层叠布局
      body: Stack(
        children: <Widget>[
          /// ... ... 页面中其他的视图
          ///抽屉视图
          buildDragWidget(),
        ],
      ),
    );
  }

  ///lib/code15/main_data1531.dart
  ///构建底部对齐的抽屉效果视图
  Widget buildDragWidget() {
    ///层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        ///抽屉关闭时的高度 默认0.4
        initChildRate: 0.1,

        ///抽屉打开时的高度 默认0.4
        maxChildRate: 0.4,

        ///是否显示默认的标题
        isShowHeader: true,

        ///背景颜色
        backGroundColor: Colors.white,

        ///背景圆角大小
        cornerRadius: 12,

        ///自动上滑动或者是下滑的分界值
        maxOffsetDistance: 1.5,

        ///抽屉控制器
        controller: dragController,

        ///滑动控制器
        scrollController: scrollController,

        ///自动滑动的时间
        duration: Duration(milliseconds: 800),

        ///抽屉的子Widget
        dragWidget: buildListView(),

        ///抽屉标题点击事件回调
        dragCallBack: (isOpen) {},
      ),
    );
  }

  ///lib/code15/main_data1531.dart
  ///可滑动布局构建 这里是一个列表ListView
  buildListView() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),

      ///列表的控制器 与抽屉视图关联
      controller: scrollController,

      ///需要注意的是这里的控制器需要使用
      ///builder函数中回调中的 控制器
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              print("点击事件 $index");

              ///关闭抽屉
              dragController.close();
            },
            child: ListTile(title: Text('测试数据 $index')));
      },
    );
  }
}
