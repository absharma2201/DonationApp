import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/Models/donations.dart';
import 'package:iwish_app/UIPages/strings.dart';
import 'package:iwish_app/app/geo_listen.dart';
import 'package:iwish_app/jobs/donation_list_tile.dart';

import 'package:iwish_app/jobs/list_items_builder.dart';
import 'package:iwish_app/jobs/new_donation_page.dart';
import 'package:iwish_app/location/streambuilder_test.dart';
import 'package:iwish_app/location/test_location.dart';

import 'package:provider/provider.dart';
import 'package:pedantic/pedantic.dart';
import 'package:intl/intl.dart';


class DonationsPage extends StatefulWidget {


  @override
  _DonationsPageState createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> with SingleTickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }


  Future<void> _delete(BuildContext context, Donation donation) async {
    final bool didDonationDelete = await showAlertDialog(
      context: context,
      title: Strings.donationDelete,
      content: Strings.donationDeleteAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.donationDelete,
    ) ??
        false;
    if (didDonationDelete == true) {
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        await database.deleteDonation(donation);
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
          title: const Text(Strings.donations),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_photo_alternate, size: 40,color: Colors.white),
              onPressed: () => showNearbyRequestChoice(context),//() => NewDonationPage.show(context),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 60.0,
                alignment: Alignment.center,
                child: Text("World is full of kind people, be One.",
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
                          text: 'Donated',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: new TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        _buildContents(context),
                        _buildContents(context),

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

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder<List<Donation>>(
      stream: database.donationsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Donation>(
          snapshot: snapshot,
          itemBuilder: (context, donation) => Dismissible(
            key: Key('donation-${donation.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, donation),
            child: DonationListTile(
              donation: donation,
              onTap: (){openBottomSheet(context, donation); },// => NewRequestPage.show(context, request: request),
            ),
          ),
        );
      },
    );
  }

  void openBottomSheet(BuildContext context, Donation donation) {
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
                        donation.description,
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
                            "${donation.category == null ? 'All Category' : donation.category.toString()}",
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
                            "${donation.date == null ? '01/01/2020' : DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(donation.createdAt)).toString()}",
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
                            "${donation.status == null ? 'Pending Approval' : donation.status.toString()}",
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
                                NewDonationPage.show(context, donation: donation);
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
                                _delete(context, donation);
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

  void showNearbyRequestChoice(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 200.0,//MediaQuery.of(context).size.height/2,
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
                        'You can choose to fulfill nearby requests',
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
                          "or ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "choose our pickup service for your donation",
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
                              onPressed: ()
                              {
                                NewDonationPage.show(context,);
                              },

                              splashColor: Colors.amber,
                              textColor: Colors.white,
                              child: Text("Donate by myself"),
                            ),
                          ),
                          Spacer(),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: RaisedButton(
                              onPressed: () {
                                {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return GeoListenPage();//StreamTestWidget();
                                  }));
                                }
                              },
                              splashColor: Colors.amber,
                              textColor: Colors.white,
                              child: Text("Nearby Requests"),
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