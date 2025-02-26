import 'package:eat_wise/Utils/Apis_utils.dart';
import 'package:eat_wise/Utils/app_colors.dart';
import 'package:eat_wise/View/Authentication/login_page.dart';
import 'package:eat_wise/View/HomePage/home_page.dart';
import 'package:eat_wise/Widgets/Buttons/ls_button.dart';
import 'package:eat_wise/Widgets/TextFields/login/ls_textfield.dart';
import 'package:eat_wise/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.greyColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Header
              Container(
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: mq.height * 0.1),

              // Signup Card
              Container(
                padding: const EdgeInsets.all(20),
                width: mq.width * 0.9,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LsTextField(
                      hintText: "abc@example.com",
                      labelText: "Email",
                      controller: emailController,
                      secure: false,
                    ),
                    const SizedBox(height: 16),
                    LsTextField(
                      labelText: "Password",
                      controller: passwordController,
                      secure: true,
                    ),
                    const SizedBox(height: 16),
                    LsTextField(
                      labelText: "Confirm Password",
                      controller: confirmPasswordController,
                      secure: true,
                    ),
                    const SizedBox(height: 24),
                    LsButton(
                      text: "Sign Up",
                      ontap: () {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          ApisUtils.auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((onValue) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }).onError(
                            (error, stackTrace) {
                              Get.snackbar("Error", error.toString());
                            },
                          );
                        } else {
                          Get.snackbar("Error", "Passwords do not match");
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: mq.height * 0.03),

              // OR divider

              SizedBox(height: mq.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
