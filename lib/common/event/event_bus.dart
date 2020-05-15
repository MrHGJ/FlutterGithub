//创建EventBus
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

//切换分支事件
class BranchSwitchEvent{
  String curBranch;
  BranchSwitchEvent(this.curBranch);
}