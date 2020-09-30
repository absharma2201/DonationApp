import 'package:iwish_app/Models/iWishUser.dart';
import 'package:iwish_app/UIPages/iwishHome.dart';
import 'package:flutter/material.dart';
import 'package:iwish_app/UIPages/authPage.dart';
import 'package:provider/provider.dart';

class iWishWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<iWishUser>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return iWishAuthPage();
    } else {
      return iWishHomePage();
    }

  }
}