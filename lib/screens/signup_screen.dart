import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_basics/resources/auth_method.dart';
import 'package:flutter_basics/screens/login_screen.dart';
import 'package:flutter_basics/utils/colors.dart';
import 'package:flutter_basics/widgets/text_field_input.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/webscreen_layout.dart';
import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUp() async {
    if (_image == null) {
      showSnackBar('Please select an image', context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final username = _usernameController.text;
    final bio = _bioController.text;
    final password = _passwordController.text;
    String res = await AuthMethods().signUpUser(
      email: email,
      password: password,
      username: username,
      bio: bio,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == 'Success') {
      //Navigator.pop(context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
      {
        return const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        );
      }));

    } else {
      showSnackBar(res, context);
    }


  }

  void navigateToLogin() {
    //Navigator.pushNamed(context, '/signup');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LoginScreen();
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
                  height: 48,
                  color: primaryColor,
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 48,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1563694983011-6f4d90358083?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              color: blueColor,
                              size: 20,
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textController: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textController: _usernameController,
                  hintText: 'Username',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textController: _bioController,
                  hintText: 'Bio',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  textController: _passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signUp,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text('Sign Up'),
                  // style: ElevatedButton.styleFrom(
                  //   minimumSize: const Size(double.infinity, 48),
                  // ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
              ],
            )),
      ),
    );
  }
}
