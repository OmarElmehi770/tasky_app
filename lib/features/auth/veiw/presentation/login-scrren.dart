import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/flashbar.dart';
import 'package:tasky_app/core/widgets/material_button_widget.dart';
import 'package:tasky_app/features/auth/veiw/presentation/register-screen.dart';
import 'package:tasky_app/features/auth/veiw/widgets/have_account_question_widget.dart';
import 'package:tasky_app/features/auth/veiw/widgets/text_form_feild_helper.dart';
import 'package:tasky_app/features/auth/veiw/widgets/validation.dart';
import 'package:tasky_app/features/home/view/presentation/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        if (await FirebaseAuth.instance.currentUser!.emailVerified) {
          setState(() {
            loading = false;
          });
          // page3
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        } else {
          setState(() {
            loading = false;
            showError('please verify your email', context);
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        if (e.code == 'wrong-password') {
          showError('password is incorrect', context);
        } else if (e.code == 'user-not-found') {
          showError('password or email is incorrect', context);
        } else if (e.code == 'invalid-credential') {
          showError('password or email is incorrect', context);
        } else if (e.code == 'network-request-failed') {
          showError('check you connection and try again', context);
        } else {
          showError(e.code, context);
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        if (context.mounted) showError(e.toString(), context);
      } finally {
        setState(() {
          loading = false;
        });
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
                spacing: 5,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xff404147),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 80),
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
                  SizedBox(height: 20),
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
                    action: TextInputAction.done,
                    onValidate: (val) {
                      if (val!.length < 8) {
                        return "password can't be less than 8 characters";
                      } else if (val.trim().isEmpty) {
                        return "password can't be empty";
                      }
                    },
                  ),
                  SizedBox(height: 70),
                  MaterialButtonWidget(
                    title: "Login",
                    loading: loading,
                    onPressed: () {
                      login();
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
              questionString: "Don't have an account?",
              actionString: "Register",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterScrren()),
                );
              },
            )
          : SizedBox.shrink(),
    );
  }
}
