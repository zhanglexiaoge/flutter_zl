import 'package:zlapp/Page/Login/user_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "UserModelEntity") {
      return UserModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}