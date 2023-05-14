import 'package:get/get.dart';
import '../controllers/auth_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthViewModel>(AuthViewModel(), permanent: true);
  }
}