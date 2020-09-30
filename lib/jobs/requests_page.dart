import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/Models/requests.dart';
import 'package:iwish_app/UIPages/strings.dart';
import 'package:iwish_app/jobs/donation_list_tile.dart';

import 'package:iwish_app/jobs/list_items_builder.dart';
import 'package:iwish_app/jobs/new_donation_page.dart';
import 'package:iwish_app/jobs/new_request_page.dart';
import 'package:iwish_app/jobs/request_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:pedantic/pedantic.dart';
import 'package:intl/intl.dart';


class RequestsPage extends StatefulWidget {


  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> with SingleTickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }


  Future<void> _delete(BuildContext context, Request request) async {
    final bool didRequestDelete = await showAlertDialog(
      context: context,
      title: Strings.requestDelete,
      content: Strings.requestDeleteAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.requestDelete,
    ) ??
        false;
    if (didRequestDelete == true) {
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        await database.deleteRequest(request);
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Colors.transparent,
          title: const Text(Strings.requests),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_photo_alternate, size: 40,color: Colors.white),
              onPressed: () => NewRequestPage.show(context),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: Text("State what you want, and go for it",
                  style:
                      Theme.of(context).textTheme.headline.apply(color: Color(0xff00c6ff)),

                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  new Container(
                  decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                    child: new TabBar(
                    controller: _controller,
                    tabs: [
                      new Tab(
                        //icon: const Icon(FontAwesomeIcons.newspaper),
                        text: 'Pending',
                      ),

                      new Tab(
                        //icon: const Icon(FontAwesomeIcons.calendarCheck),
                        text: 'Delivered',
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: new TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      _buildContentsP(context),
                      _buildContentsD(context),

                    ],
                  ),
                ),

              ],
            ),
    ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentsP(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder<List<Request>>(
      stream: database.requestsPStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Request>(
          snapshot: snapshot,
          itemBuilder: (context, request) => Dismissible(
            key: Key('request-${request.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, request),
            child: RequestListTile(
              request: request,
              onTap: (){openBottomSheet(context, request); },// => NewRequestPage.show(context, request: request),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContentsD(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder<List<Request>>(
      stream: database.requestsDStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Request>(
          snapshot: snapshot,
          itemBuilder: (context, request) => Dismissible(
            key: Key('request-${request.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, request),
            child: RequestListTile(
              request: request,
              onTap: (){openBottomSheet(context, request); },// => NewRequestPage.show(context, request: request),
            ),
          ),
        );
      },
    );
  }

  void openBottomSheet(BuildContext context, Request request) {
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
                    Expanded(
                      child:
                      Text(
                        request.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    Divider(),

                    Row(
                      children: <Widget>[
                        Text(
                          "Category : ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${request.category == null ? 'All Category' : request.category.toString()}",
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
                            "${request.date == null ? '01/01/2020' : DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(request.createdAt)).toString()}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          "Status : ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${request.status == null ? 'Pending Approval' : request.status.toString()}",
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
                                NewRequestPage.show(context, request: request);
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
                                _delete(context, request);
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