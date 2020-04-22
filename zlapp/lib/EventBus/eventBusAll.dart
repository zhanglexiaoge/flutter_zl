import 'package:event_bus/event_bus.dart';
import 'package:zlapp/Page/Login/user_model_entity.dart';
import 'dart:async';
EventBus eventBus = EventBus();
class UserModelEvent{
  UserModelEntity model;
  UserModelEvent(userModel) {
    this.model = userModel;
  }
}