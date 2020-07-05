
# flutter 上拉抽屉效果 flutter 抽屉

**题记**
  ——  执剑天涯，从你的点滴积累开始，所及之处，必精益求精，即是折腾每一天。
  
**重要消息**

* [网易云【玩转大前端】配套课程](https://study.163.com/instructor/1021406098.htm)
* [EDU配套  教程](https://edu.csdn.net/lecturer/1555)

* [Flutter开发的点滴积累系列文章](https://blog.csdn.net/zl18603543572/article/details/93532582)

*** 


#### 1 添加依赖

实现抽屉效果，在这里使用drag_container依赖库，首先是引用依赖，通过pub仓库添加依赖，代码如下：[最新版本查看这里](https://pub.flutter-io.cn/packages/drag_container)

```java
  dependencies:
	drag_container: ^0.0.1
```

或者是通过github方式添加依赖，代码如下：

```java
dependencies:
	drag_container:
	      git:
	        url: https://github.com/zhaolongs/drag_container.git
	        ref: master
```

然后加载依赖，代码如下：

```java
flutter pub get
```

然后在使用的地方导包，代码如下：

```java
import 'package:drag_container/drag_container.dart';
```
然后就可以使用 DragContainer 抽屉布局。
#### 2 DragContainer抽屉视图基本使用
如上图所示的效果，为抽屉视图浮在主视图的上层，所以页面主体内容可考虑使用层叠布局，代码如下：

```java
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
 ... ... 省略
}
```
在这里也声明创建了一个ScrollController ，用于抽屉视图中的滑动视图，声明的抽屉控制器DragController 用来控制抽屉的打开与关闭，代码如下：

```java
  ///关闭抽屉
 dragController.close();
  ///打开抽屉
 dragController.open();
```

buildDragWidget方法就是用来创建DragContainer 抽屉组件的方法，

```java
  ///构建底部对齐的抽屉效果视图
  Widget buildDragWidget(){
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
        maxOffsetDistance:1.5,
        ///抽屉控制器
        controller: dragController,
        ///滑动控制器
        scrollController: scrollController,
        ///自动滑动的时间
        duration: Duration(milliseconds: 800),
        ///抽屉的子Widget
        dragWidget: buildListView(),
        ///抽屉标题点击事件回调
        dragCallBack: (isOpen){ },
      ),
    );
  }

```

在这里通过buildListView方法来构建了一个抽屉中使用的滑动视图ListView，需要注意的是，抽屉视图中一般都使用滑动视图，代码如下：

```java
  ///可滑动布局构建 这里是一个列表ListView
  buildListView() {
    return ListView.builder(
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
```

运行效果如下：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200705210113660.gif)
![公众号 我的大前端生涯](https://img-blog.csdnimg.cn/20200620175409480.gif)