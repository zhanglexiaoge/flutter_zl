import 'package:zlapp/Page/Home/mock/home_girder_model_entity.dart';
import 'package:zlapp/Page/Home/mock/home_list_model_entity.dart';
import 'package:zlapp/Page/Home/home_banner_model_entity.dart';
import 'package:zlapp/Page/Login/user_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HomeGirderModelEntity") {
      return HomeGirderModelEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeListModelEntity") {
      return HomeListModelEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeBannerModelEntity") {
      return HomeBannerModelEntity.fromJson(json) as T;
    } else if (T.toString() == "UserModelEntity") {
      return UserModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}