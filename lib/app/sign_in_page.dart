import 'dart:math';

import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';
import 'package:iwish_app/UIPages/keys.dart';
import 'package:iwish_app/UIPages/router.dart';
import 'package:iwish_app/UIPages/strings.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'sign_in_view_model.dart';
import 'sign_in_button.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]),
            child: child
        ),
      ),
    );
  }
}

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(auth: auth),
      child: Consumer<SignInViewModel>(
        builder: (_, viewModel, __) => SignInPage._(
          viewModel: viewModel,
          title: 'iWish',
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({Key key, this.viewModel, this.title}) : super(key: key);
  final SignInViewModel viewModel;
  final String title;

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  Future<void> _showSignInError(BuildContext context, dynamic exception) async {
    await showExceptionAlertDialog(
      context: context,
      title: Strings.signInFailed,
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await viewModel.signInAnonymously();
    } catch (e) {
      await _showSignInError(context, e);
    }
  }

  Future<void> _showEmailPasswordSignInPage(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      Routes.emailPasswordSignInPage,
      arguments: () => navigator.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      Strings.signIn,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: min(constraints.maxWidth, 600),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 300,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Sign In", style: TextStyle(color: Colors.black87, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                /*
                SizedBox(
                  height: 50.0,
                  child: _buildHeader(),
                ),
                */
                SignInButton(
                  key: emailPasswordButtonKey,
                  text: Strings.signInWithEmailPassword,
                  onPressed: viewModel.isLoading
                      ? null
                      : () => _showEmailPasswordSignInPage(context),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
                /*
                const SizedBox(height: 8),
                Text(
                  Strings.or,
                  style: TextStyle(fontSize: 14.0, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                SignInButton(
                  key: anonymousButtonKey,
                  text: Strings.goAnonymous,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: viewModel.isLoading
                      ? null
                      : () => _signInAnonymously(context),
                ),

                */
              ],
            ),
          );
        }),
      ),
    );
  }
}
