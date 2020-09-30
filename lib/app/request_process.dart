
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          title: Text('How can you Request'),
        ),        body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 50.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.signInAlt, size: 50,),
                        SizedBox(width: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*.6,
                          child: Text(
                            "1. Sign In and State your request",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subhead.apply(color: Color(0xFF2d3447)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 8.0, bottom: 8.0, right: 8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[

                        Container(
                          width: MediaQuery.of(context).size.width*.6,
                          child: Text(
                            "2. Choose between category of requests ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subhead.apply(color: Color(0xFF2d3447)),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(
                          FontAwesomeIcons.signInAlt, size: 50,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 50.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.signInAlt, size: 50,),
                        SizedBox(width: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*.6,
                          child: Text(
                            "3. Fill form with your request item details and submit.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subhead.apply(color: Color(0xFF2d3447)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 8.0, bottom: 8.0, right: 8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffE5E5E5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[

                        Container(
                          width: MediaQuery.of(context).size.width*.6,
                          child: Text(
                            "4. Track your request",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subhead.apply(color: Color(0xFF2d3447)),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(
                          FontAwesomeIcons.signInAlt, size: 50,),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),

      ),
      ),
    );
  }
}
