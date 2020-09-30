import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/UIPages/router.dart';
import 'package:iwish_app/UIPages/slider_view.dart';
import 'package:iwish_app/UIPages/splash_screen.dart';
import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/UIPages/theme.dart';
import 'package:iwish_app/app/home_page.dart';
import 'package:iwish_app/app/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:iwish_app/CloudDatabase/auth_widget_builder.dart';

/*
hello
void main()  {
  runApp(MaterialApp(
      home: iWishSplashScreen(), title: 'iWish App design',
  )
  );
}
*/
void main() => runApp(MyApp(
      authServiceBuilder: (_) => FirebaseAuthService(),
      databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
      storageBuilder: (_, uid) => StorageService(uid: uid),
    ));

class MyApp extends StatelessWidget {
  const MyApp(
      {Key key,
      this.authServiceBuilder,
      this.databaseBuilder,
      this.storageBuilder})
      : super(key: key);
  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirebaseAuthService Function(BuildContext context) authServiceBuilder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;
  final StorageService Function(BuildContext context, String uid)
      storageBuilder;

  @override
  Widget build(BuildContext context) {
    // MultiProvider for top-level services that don't depend on any runtime values (e.g. uid)
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: authServiceBuilder,
        ),
      ],
      child: AuthWidgetBuilder(
        userProvidersBuilder: (_, user) => [
          Provider<User>.value(value: user),
          Provider<FirestoreDatabase>(
            create: (_) => FirestoreDatabase(uid: user.uid),
          ),
          Provider<StorageService>(
            create: (_) => StorageService(uid: user.uid),
          ),
        ],
        builder: (context, userSnapshot) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor:
                  Color(0xFF2d3447), //Color(0xffE5E5E5),//Color(0xFFFFFFFF),
              primaryColor: Color(0xFF2d3447), //Color(0xFFFF4700),
            ),
            debugShowCheckedModeBanner: false,
            home: AuthWidget(
              userSnapshot: userSnapshot,
              nonSignedInBuilder: (_) => LandingPage(), //SignInPageBuilder(),
              signedInBuilder: (_) => HomePage(),
            ),
            onGenerateRoute: Router.onGenerateRoute,
          );
        },
      ),
    );
  }
}
