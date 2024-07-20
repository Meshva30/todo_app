import 'package:get/get.dart';
import 'package:todo_app/view/homescreen.dart';

class LoginController extends GetxController{

  var email= ''.obs;
  var password= ''.obs;
  var emailError= ''.obs;
  var passwordError= ''.obs;
  var isLoading= false.obs;
  bool validateEmail(String email)
  {
    if(!GetUtils.isEmail(email))
      {
        emailError.value='Invaild email';
        return false;
      }
    emailError.value='';
    return true;
  }

  bool vaildatePassword(String password)
  {
    if(password.length<6)
      {
        passwordError.value ='password must be at least 6 characters';
        return false;
      }
    passwordError.value='';
    return true;
  }

  void login()
  {
    if(validateEmail(email.value)&& vaildatePassword(password.value))
      {
        isLoading.value = true;
        Future.delayed(Duration(seconds: 2),() {
          isLoading.value = false;
          Get.off(() => Homescreen());
        },);
      }
  }
}