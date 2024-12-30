import 'package:design_notes/authentication/signup_screen.dart';
import 'package:design_notes/data/auth_services.dart';
import 'package:design_notes/global_widgets/button_widget.dart';
import 'package:design_notes/global_widgets/text_field_widget.dart';
import 'package:design_notes/screens/home_screen.dart';
import 'package:design_notes/utilities/app_colors.dart';
import 'package:design_notes/utilities/app_text_styles_poppins.dart';
import 'package:design_notes/utilities/validator.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isVisible = true;
  final _formKey = GlobalKey<FormState>(); // Correct form key

  final emailController = TextEditingController();
  final passController = TextEditingController();
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with login logic
      final email = emailController.text.trim();
      final password = passController.text.trim();

      AuthService().signUpWithEmail(email, password).then((v){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      });

      // Add login logic here (e.g., API call)
      print('Email: $email, Password: $password');
    } else {
      // Form is invalid
      print("Validation failed");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Welcome to SupBase Notes ",
                  style: twenty600TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "SignIn with your email",
                  style: twenty600TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                          validator: Validator.emailValidator,
                          textFieldController: emailController,
                          hintText: "Email", obscureText: false),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldWidget(
                        textFieldController: passController,
                        validator: Validator.passwordValidator,
                        hintText: "Password",

                        obscureText: isVisible,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Icon(
                              isVisible == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Column(
                  children: [
                    BigButton(
                        width: double.infinity,
                        height: 50,
                        text: "Login ",
                        onTap:_login,
                        textStyle: fourteen400TextStyle(color: offWhiteColor),
                        containerColor: greenColor),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login with ",
                          style: sixteen400TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/googleIcon.png"))),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),   SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: sixteen400TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),

                        GestureDetector(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                            },
                            child: Text("Signup", style: sixteen400TextStyle(color: Colors.red),)),

                        SizedBox(width: 10,),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
