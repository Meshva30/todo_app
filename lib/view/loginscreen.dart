import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/homescreen.dart';
import '../controller/login_controller.dart';

class Loginscreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "see your growth and get consulting suppor!",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/google.png"),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => controller.email.value = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Email',
                    hintText: 'abc@email.com',
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.white),
                    helperStyle: TextStyle(color: Colors.white),
                    errorText: controller.emailError.value.isEmpty
                        ? null
                        : controller.emailError.value,
                  ),
                )),
            SizedBox(height: 20),
            Obx(() => TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) => controller.password.value = value,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'min.8 character',
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    errorText: controller.passwordError.value.isEmpty
                        ? null
                        : controller.passwordError.value,
                  ),
                )),
            SizedBox(height: 50),
            Obx(
              () => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : InkWell(
                      onTap: controller.login,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffE50BFF),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                            child: Text("Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500))),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
