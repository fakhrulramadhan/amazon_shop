import 'package:amazon_shop/common/widgets/custom_button.dart';
import 'package:amazon_shop/common/widgets/custom_textfield.dart';
import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/data/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signIn; //nilai awalnya sign in
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        context: context);
  }

  void signinUser() {
    authService.signInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        appBar: AppBar(
          title: const Text("Auth Screen"),
          actions: const [],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signUp
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  value: Auth.signUp,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    _auth = val!; //nilai auth yang sekarang adalah kebalikannya
                    setState(() {});
                  },
                  activeColor: GlobalVariables.secondaryColor,
                ),
              ),
              if (_auth == Auth.signUp)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            hintText: "Name",
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            hintText: "Email Address",
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomButton(
                            text: "Sign Up",
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          )
                        ],
                      )),
                ),
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  value: Auth.signIn,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    _auth = val!; //nilai auth yang sekarang adalah kebalikannya
                    setState(() {});
                  },
                  activeColor: GlobalVariables.secondaryColor,
                ),
              ),
              if (_auth == Auth.signIn)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hintText: "Email Address",
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomButton(
                            text: "Sign In",
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signinUser();
                              }
                            },
                          )
                        ],
                      )),
                ),
            ],
          ),
        )));
  }
}
