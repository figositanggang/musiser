import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiser/src/features/auth/auth_controller.dart';
import 'package:musiser/src/features/auth/page/register_page.dart';
import 'package:musiser/src/helpers/auth_helper.dart';
import 'package:musiser/src/utils/custom_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final formKey = GlobalKey<FormState>();
  final authGet = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width / 9,
                      ),
                      child: Column(
                        children: [
                          // @ Login Text
                          const Align(
                            alignment: Alignment.topLeft,
                            child: MyText(
                              "Login",
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // @ Email Field
                          MyTextField(
                            controller: emailController,
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          // @ Password Field
                          Obx(
                            () => MyTextField(
                              controller: passwordController,
                              hintText: "Password",
                              obscureText: authGet.secure,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  authGet.setSecure(!authGet.secure);
                                },
                                icon: authGet.secure
                                    ? const Icon(Icons.visibility_off)
                                    : Icon(
                                        Icons.visibility,
                                        color: Theme.of(context).primaryColor,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // @ Login Button
                          SizedBox(
                            width: double.maxFinite,
                            child: MyButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  login();
                                }
                              },
                              child: const MyText(
                                "Login",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // @ Register Button
                          SizedBox(
                            width: double.maxFinite,
                            child: MyButton(
                              onPressed: () {
                                Get.to(const RegisterPage());
                              },
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.5),
                                ),
                              ),
                              child: const MyText("Create Account"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void login() async {
    showDialog(
      context: context,
      builder: (context) => MyLoading.Loading(context),
    );

    String _login = await AuthHelper.logIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    Get.back();
    if (_login != "Y" && context.mounted) {
      showSnackBar(context, content: _login, backgroundColor: Colors.red);
      return;
    }
  }
}
