import 'package:budget_pro/domain/authentication/auth_repository.dart';
import 'package:budget_pro/domain/bloc/login_progress_indicator_cubit.dart';
import 'package:budget_pro/domain/routes/routes.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailPinController = TextEditingController();
  final TextEditingController _passwordPinController = TextEditingController();
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
          'Log In',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          loginScreen(),
          if (context.watch<LoginProgressIndicatorCubit>().state)
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

  Column loginScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            width: 240,
            height: 240,
            'assets/images/log_in.png',
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
              SizedBox(height: 40),
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    authRepository.logIn(
                      _emailPinController.text,
                      _passwordPinController.text,
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
                        'Log In',
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
                  const Text("Don't have an account"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signUp);
                    },
                    child: const Text(
                      'Sing Up',
                      style: TextStyle(
                        color: AppColors.navigatorColor,
                        decoration: TextDecoration.underline,
                      ),
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
