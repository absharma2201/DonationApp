import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/Models/enquiry.dart';
import 'package:iwish_app/Models/requests.dart';
import 'package:iwish_app/UIPages/strings.dart';
import 'package:iwish_app/jobs/donation_list_tile.dart';
import 'package:iwish_app/jobs/enquiry_list_tile.dart';

import 'package:iwish_app/jobs/list_items_builder.dart';
import 'package:iwish_app/jobs/new_donation_page.dart';
import 'package:iwish_app/jobs/new_enquiry.dart';
import 'package:iwish_app/jobs/new_request_page.dart';
import 'package:iwish_app/jobs/request_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:pedantic/pedantic.dart';
import 'package:intl/intl.dart';


class EnquiryPage extends StatefulWidget {


  @override
  _EnquiryPageState createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage>{

  @override
  void initState() {
    super.initState();
  }

/*
  Future<void> _delete(BuildContext context, Enquiry enquiry) async {
    final bool didEnquiryDelete = await showAlertDialog(
      context: context,
      title: Strings.enquiryDelete,
      content: Strings.enquiryDeleteAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.enquiryDelete,
    ) ??
        false;
    if (didEnquiryDelete == true) {
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        await database.deleteEnquiry(enquiry);
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Colors.transparent,
          title: const Text('Enquiry'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box, size: 40,color: Colors.white),
              onPressed: () => NewEnquiryPage.show(context),
            ),
          ],
        ),
        body: _buildContents(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder<List<Enquiry>>(
      stream: database.enquiryStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Enquiry>(
          snapshot: snapshot,
          itemBuilder: (context, enquiry) => Dismissible(
            key: Key('enquiry-${enquiry.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {},// => _delete(context, enquiry),
            child: EnquiryListTile(
              enquiry: enquiry,
              onTap: (){openBottomSheet(context, enquiry); },// => NewRequestPage.show(context, request: request),
            ),
          ),
        );
      },
    );
  }

  void openBottomSheet(BuildContext context, Enquiry enquiry) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500.0,//MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Subject: ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${enquiry.title == null ? 'No content.' : enquiry.title}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          "Date: ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${enquiry.date == null ? '01/01/2020' : DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(enquiry.createdAt)).toString()}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    Divider(),

                    Row(
                      children: <Widget>[
                        Text(
                          "Enquiry: ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${enquiry.description == null ? 'No content.' : enquiry.description}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    Divider(),

                    Row(
                      children: <Widget>[
                        Text(
                          "Response: ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${enquiry.reply == null ? 'No response yet.' : enquiry.reply}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: RaisedButton(
                              onPressed: () {
                                NewEnquiryPage.show(context, enquiry: enquiry);
                              },
                              splashColor: Colors.amber,
                              textColor: Colors.white,
                              child: Text("Update"),
                            ),
                          ),
                          Spacer(),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: RaisedButton(
                              onPressed: () {
                               // _delete(context, enquiry);
                              },
                              splashColor: Colors.amber,
                              textColor: Colors.white,
                              child: Text("Delete"),
                            ),
                          )

                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        });
  }
}


