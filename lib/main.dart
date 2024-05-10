import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics/providers/user_provider.dart';
import 'package:flutter_basics/responsive/mobile_screen_layout.dart';
import 'package:flutter_basics/responsive/responsive_layout_screen.dart';
import 'package:flutter_basics/responsive/webscreen_layout.dart';
import 'package:flutter_basics/screens/login_screen.dart';
import 'package:flutter_basics/screens/signup_screen.dart';
import 'package:flutter_basics/utils/colors.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.dark()
                .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),

            // home: const ResponsiveLayout(
            //     mobileScreenLayout: MobileScreenLayout(),
            //     webScreenLayout: WebScreenLayout(),
            // )
            home: StreamBuilder(
              stream: Firebase.initializeApp().asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  );
                }
                //CHECK IF ERROR
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('${snapshot.error}'),
                    ),
                  );
                }

                //if there id no snapshot return LoginScreen
                if (!snapshot.hasData) {
                  return const LoginScreen();
                }

                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              },
            )));
  }
}
