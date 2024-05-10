import 'package:flutter/material.dart';
import 'package:flutter_basics/responsive/mobile_screen_layout.dart';
import 'package:flutter_basics/responsive/responsive_layout_screen.dart';
import 'package:flutter_basics/responsive/webscreen_layout.dart';
import 'package:flutter_basics/screens/signup_screen.dart';
import 'package:flutter_basics/utils/colors.dart';
import 'package:flutter_basics/utils/utils.dart';
import 'package:flutter_basics/widgets/text_field_input.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_basics/resources/auth_method.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      _isLoading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    String res = await AuthMethods().loginUser(
      email: email,
      password: password,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'Success') {
      showSnackBar(res, context);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
        );
      }));
    }
  }

  void navigateToSignUp() {
    //Navigator.pushNamed(context, '/signup');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login Screen'),
      // ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  height: 64,
                  color: primaryColor,
                ),
                const SizedBox(height: 64),
                TextFieldInput(
                  textController: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textController: _passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: login,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                  // style: ElevatedButton.styleFrom(
                  //   minimumSize: const Size(double.infinity, 48),
                  // ),
                ),
                const SizedBox(height: 24),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        navigateToSignUp();
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
