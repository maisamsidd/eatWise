import 'package:eat_wise/Utils/Apis_utils.dart';
import 'package:eat_wise/Utils/app_colors.dart';
import 'package:eat_wise/View/Authentication/signup_page.dart';
import 'package:eat_wise/View/Authentication/test_page.dart';
import 'package:eat_wise/View/HomePage/home_page.dart';
import 'package:eat_wise/Widgets/Buttons/ls_button.dart';
import 'package:eat_wise/Widgets/TextFields/login/ls_textfield.dart';
import 'package:eat_wise/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: mq.height * 0.1),
              Text(
                "Welcome back",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: MyColors.whiteColor),
              ),
              Text(
                "Login to continue",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyColors.whiteColor),
              ),
              SizedBox(height: mq.height * 0.05),
              Container(
                padding: const EdgeInsets.all(20),
                width: mq.width * 0.9,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Divider(thickness: 1, indent: 30, endIndent: 10)),
                  Text("Or", style: TextStyle(fontSize: 15)),
                  Expanded(
                      child: Divider(thickness: 1, indent: 10, endIndent: 30)),
                ],
              ),
              SizedBox(height: mq.height * 0.03),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: mq.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
