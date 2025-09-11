import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/widgets/flashbar.dart';
import 'package:tasky_app/core/widgets/material_button_widget.dart';
import 'package:tasky_app/features/auth/data/firebase/firebase_data.dart';
import 'package:tasky_app/features/auth/veiw/widgets/have_account_question_widget.dart';
import 'package:tasky_app/features/auth/veiw/widgets/text_form_feild_helper.dart';
import 'package:tasky_app/features/auth/veiw/widgets/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScrren extends StatefulWidget {
  const RegisterScrren({super.key});

  @override
  State<RegisterScrren> createState() => _RegisterScrrenState();
}

class _RegisterScrrenState extends State<RegisterScrren> {
  var username = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.toString(),
          password: password.text.toString(),
        );

        await FirebaseAuth.instance.currentUser!.sendEmailVerification();

        await AuthFirebase.createUser(
          email: email.text,
          password: password.text,
          userName: username.text,
        );

        setState(() {
          loading = false;
        });

        showSuccess("Successfully", context);
      } catch (error) {
        setState(() {
          loading = false;
        });
        showError(error.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Register",
                    style: TextStyle(
                      color: Color(0xff404147),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Color(0xff404147),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextFormFieldHelper(
                    borderRadius: BorderRadius.circular(10),
                    controller: username,
                    hint: "Enter username",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    onValidate: (val) {
                      if (val!.trim().isEmpty) {
                        return "Username can't be empty";
                      }
                    },
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      color: Color(0xff404147),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextFormFieldHelper(
                    borderRadius: BorderRadius.circular(10),
                    controller: email,
                    hint: "Enter your Email",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    onValidate: (val) {
                      if (!val!.isValidEmail()) {
                        return "Enter valid email";
                      } else if (val.trim().isEmpty) {
                        return "Email can't be empty";
                      }
                    },
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      color: Color(0xff404147),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextFormFieldHelper(
                    borderRadius: BorderRadius.circular(10),
                    controller: password,
                    hint: "Enter Password",
                    isPassword: true,
                    action: TextInputAction.next,
                    onValidate: (val) {
                      if (val!.length < 8) {
                        return "password can't be less than 8 characters";
                      } else if (val.trim().isEmpty) {
                        return "password can't be empty";
                      }
                    },
                  ),
                  Text(
                    "Confirm password",
                    style: TextStyle(
                      color: Color(0xff404147),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextFormFieldHelper(
                    borderRadius: BorderRadius.circular(10),
                    controller: confirmPassword,
                    isPassword: true,
                    hint: "Enter password",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.done,
                    onValidate: (val) {
                      if (val != password.text) {
                        return "Please, enter The same password";
                      }
                    },
                  ),
                  SizedBox(height: 70),
                  MaterialButtonWidget(
                    title: "Register",
                    loading: loading,
                    onPressed: loading
                        ? null
                        : () {
                            setState(() {
                              register();
                            });
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: MediaQuery.of(context).viewInsets.bottom != true
          ? HaveAccountQuestionWidget(
              questionString: "Already have an account?",
              actionString: "Sign in",
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : SizedBox.shrink(),
    );
  }
}
