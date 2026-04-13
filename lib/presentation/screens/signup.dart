import 'package:budget_pro/domain/authentication/auth_repository.dart';
import 'package:budget_pro/domain/bloc/signup_progress_indicator_cubit.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailPinController = TextEditingController();
  final TextEditingController _passwordPinController = TextEditingController();
  final TextEditingController _confirmPasswordPinController =
      TextEditingController();
  AuthRepository authRepository = AuthRepository();
  bool _passwordVisible = true;

  @override
  void dispose() {
    _emailPinController.dispose();
    _passwordPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          signupScreen(),
          if (context.watch<SignupProgressIndicatorCubit>().state)
            Stack(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
                Center(child: CircularProgressIndicator()),
              ],
            ),
        ],
      ),
    );
  }

  Column signupScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            width: 240,
            height: 240,
            'assets/images/sign_up.png',
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _emailPinController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hint: const Text(
                    'Email',
                    style: TextStyle(color: Colors.grey),
                  ),
                  prefixIcon: Icon(
                    FontAwesomeIcons.solidEnvelope,
                    size: 20,
                    color: Colors.grey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 177, 177, 177),
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _passwordPinController,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hint: const Text(
                    'Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  prefixIcon: Icon(
                    FontAwesomeIcons.lock,
                    size: 20,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: _passwordVisible
                        ? Icon(FontAwesomeIcons.eyeSlash)
                        : Icon(FontAwesomeIcons.eye),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 177, 177, 177),
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _confirmPasswordPinController,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hint: const Text(
                    'Confirm Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  prefixIcon: Icon(
                    FontAwesomeIcons.lock,
                    size: 20,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: _passwordVisible
                        ? Icon(FontAwesomeIcons.eyeSlash)
                        : Icon(FontAwesomeIcons.eye),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 177, 177, 177),
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    authRepository.signUpUser(
                      _emailPinController.text,
                      _passwordPinController.text,
                      _confirmPasswordPinController.text,
                      context,
                    );
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.navigatorColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: const Text(
                        'Sing Up',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account"),
                  SizedBox(width: 5),
                  const Text(
                    'Log In',
                    style: TextStyle(
                      color: AppColors.navigatorColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
