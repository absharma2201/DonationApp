//EnquiryListTile
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/Models/enquiry.dart';
import 'package:intl/intl.dart';


class EnquiryListTile extends StatelessWidget {
  const EnquiryListTile({Key key, @required this.enquiry, this.onTap})
      : super(key: key);
  final Enquiry enquiry;
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
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                //image: new AssetImage('assets/'+ request.name +'.png'),
                FontAwesomeIcons.mailchimp,
                size: 50.0,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            enquiry.title,
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
                      Text(DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(enquiry.createdAt)).toString(), style: TextStyle(color: Colors.white)),
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
