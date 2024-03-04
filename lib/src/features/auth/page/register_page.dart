import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musiser/src/features/auth/auth_controller.dart';
import 'package:musiser/src/features/auth/page/auth_state.dart';
import 'package:musiser/src/helpers/auth_helper.dart';
import 'package:musiser/src/utils/custom_widgets.dart';
import 'package:musiser/src/utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController fullNameController;
  late TextEditingController passwordController;

  final formKey = GlobalKey<FormState>();
  final authGet = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    usernameController = TextEditingController();
    fullNameController = TextEditingController();
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
                          // @ Register Text
                          const Align(
                            alignment: Alignment.topLeft,
                            child: MyText(
                              "Register",
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // @ Email Field
                          MyTextField(
                            controller: emailController,
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return Validators.emailValidator(value!);
                            },
                          ),
                          const SizedBox(height: 20),

                          // @ Username Field
                          MyTextField(
                            controller: usernameController,
                            hintText: "Username",
                            validator: (value) {
                              return Validators.usernameValidator(value!);
                            },
                          ),
                          const SizedBox(height: 20),

                          // @ Full Name Field
                          MyTextField(
                            controller: fullNameController,
                            hintText: "Full Name",
                          ),
                          const SizedBox(height: 20),

                          // @ Password Field
                          Obx(
                            () => MyTextField(
                              controller: passwordController,
                              hintText: "Password",
                              obscureText: authGet.secure,
                              validator: (value) {
                                return Validators.passwordValidator(value!);
                              },
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

                          // @ Register Button
                          MyButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                createAccount();
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  "Create",
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // @ Back to login Button
                          MyButton(
                            onPressed: () {
                              Get.back();
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText("Back to login"),
                              ],
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

  void createAccount() async {
    showDialog(
      context: context,
      builder: (context) => MyLoading.Loading(context),
    );

    bool isUsernameAvailable =
        await AuthHelper.checkUsername(usernameController.text.trim());

    // ! username not available
    if (!isUsernameAvailable && context.mounted) {
      Get.back();

      showSnackBar(context,
          content: "Username telah digunakan", backgroundColor: Colors.red);
      return;
    }

    String isRegistered = await AuthHelper.createAccount(
      email: emailController.text.trim(),
      username: usernameController.text.trim(),
      fullName: fullNameController.text.trim(),
      password: passwordController.text.trim(),
    );

    // ! failed create user
    if (isRegistered != "Y" && context.mounted) {
      Get.back();

      showSnackBar(
        context,
        content: isRegistered,
        backgroundColor: Colors.red,
      );
      return;
    }

    if (context.mounted) {
      Get.back();

      Get.offAll(const AuthStatePage());

      showSnackBar(context, content: "User created");
    }
  }
}
