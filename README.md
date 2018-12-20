# SegmentTableView
在 *主TableView* 的cell中嵌套分页控件，分页控件中是 *子TableView*，主、子tableView流畅滚动

基本思路：

（1）将多个 **子tableView** 放在**主tableView**的一个cell中，用分页控件包装起来；（也可以直接用scrollview来实现，都可以）；

（2）使用delegate来关联**主tableView**和**子tableView**中的scrollViewDidScroll事件，以便将所有的滚动控制都放到那个分页cell中；

（3）让 **主tableView** 继承UIGestureRecognizerDelegate协议并实现gestureRecognizer接口，用于在滚动内层 **子tableView** 的同时，也同时触发主tableView的scrollViewDidScroll:事件；

（4）控制 **主tableView** 和 **子tableView** 在scrollViewDidScroll事件触发后，两个tableView的正确绘制位置；

下图是界面截图：
![demo](https://github.com/smalltask/SegmentTableView/blob/master/demo1.png?raw=false)

