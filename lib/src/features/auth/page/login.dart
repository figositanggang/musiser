import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
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
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width / 9,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // @ Login Text
                          const Align(
                            alignment: Alignment.topLeft,
                            child: MyText(
                              text: "Login",
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
                          const SizedBox(height: 10),

                          // @ Password Field
                          MyTextField(
                            controller: passwordController,
                            hintText: "Password",
                          ),
                          const SizedBox(height: 10),

                          // @ Login Button
                          SizedBox(
                            width: double.maxFinite,
                            child: MyButton(
                              onPressed: () {},
                              child: Text("Login"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(alignment: Alignment.bottomCenter, child: Text("Aw")),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
