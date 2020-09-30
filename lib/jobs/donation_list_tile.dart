import 'package:flutter/material.dart';
import 'package:iwish_app/Models/donations.dart';
import 'package:iwish_app/UIPages/fonts_access.dart';
import 'package:intl/intl.dart';

class DonationListTile extends StatelessWidget {
  const DonationListTile({Key key, @required this.donation, this.onTap})
      : super(key: key);
  final Donation donation;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.white),
          borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
                colors: [
                  Color(0xFF1b1e44),
                  Color(0xFF2d3447),
                ],
)
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 2.0, color: Color(0xff00c6ff),
                    ))),
            child: Image(
              image: new AssetImage('assets/Books.png'),
              height: 92.0,
              width: 92.0,
            ),
          ),
          title: Text(
            donation.description,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale, color: Color(0xff00c6ff),),
                        Text(DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(donation.createdAt)).toString(), style: TextStyle(color: Colors.white)),
                      ],
                    ),
                ),
              )
            ],
          ),
          trailing: Icon(Icons.chevron_right, color: Color(0xff00c6ff), size: 30.0),
          onTap: onTap,

        ),
      ),
    );
  }
}
