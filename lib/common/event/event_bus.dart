//创建EventBus
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

//切换分支事件
class BranchSwitchEvent {
  String curBranch;

  BranchSwitchEvent(this.curBranch);
}

//搜索事件
class SearchEvent {
  String searchWords;
  SearchEvent({this.searchWords});
}
