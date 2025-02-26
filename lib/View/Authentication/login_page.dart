import 'package:eat_wise/Utils/Apis_utils.dart';
import 'package:eat_wise/Utils/app_colors.dart';
import 'package:eat_wise/View/Authentication/signup_page.dart';
import 'package:eat_wise/View/HomePage/home_page.dart';
import 'package:eat_wise/Widgets/Buttons/ls_button.dart';
import 'package:eat_wise/Widgets/TextFields/login/ls_textfield.dart';
import 'package:eat_wise/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: mq.height * 0.1),

              // Login Card
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
                    const SizedBox(height: 24),
                    LsButton(
                      text: "Login",
                      ontap: () {
                        ApisUtils.auth
                            .signInWithEmailAndPassword(
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
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a member?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: const Text(
                            "Create a free account",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                      child: Divider(thickness: 1, indent: 30, endIndent: 10)),
                  Text("Or", style: TextStyle(fontSize: 15)),
                  Expanded(
                      child: Divider(thickness: 1, indent: 10, endIndent: 30)),
                ],
              ),
              SizedBox(height: mq.height * 0.03),

              // Google Sign-In Button
              GestureDetector(
                onTap: () {
                  // Add Google sign-in logic here
                },
                child: Container(
                  height: 50,
                  width: mq.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.google, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: mq.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
