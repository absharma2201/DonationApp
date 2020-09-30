import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/Models/events.dart';
import 'package:iwish_app/Models/posts.dart';
import 'package:iwish_app/UIPages/router.dart';
import 'package:provider/provider.dart';

import 'package:pedantic/pedantic.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({Key key, this.event}) : super(key: key);
  final Event event;

  static Future<void> show(BuildContext context, {Event event}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      Routes.newEventPage,
      arguments: event,
    );
  }

  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final _formKey = GlobalKey<FormState>();
  /// Active image file
  File _imageFile;

  String _name;
  String _title;
  String _city;
  String _story;
  String _eventImageUrl;
  String _date;
  int _duration;
  int _attendees;


  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _name = widget.event.name;
      _title = widget.event.title;
      _city = widget.event.city;
      _story = widget.event.story;
      _eventImageUrl = widget.event.eventImageUrl;
      _duration = widget.event.duration;
      _attendees= widget.event.attendees;
      _date = widget.event.date;


    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        //final storage = Provider.of<StorageService>(context, listen: false);
        final events = await database.eventsStream().first;
        final allLowerCaseNames =
        events.map((event) => event.name.toLowerCase()).toList();
        if (widget.event != null) {
          allLowerCaseNames.remove(widget.event.name.toLowerCase());
        }

        final id = widget.event?.id ?? documentIdFromCurrentDate();
        final event = Event(id: id, name: _name, title: _title, city: _city,
          story: _story, eventImageUrl: _eventImageUrl, duration: _duration, date: _date,
          attendees: _attendees,
        );
        await database.setEvent(event);
        Navigator.of(context).pop();

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
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.event == null ? 'New Event' : 'Edit Event'),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      //backgroundColor: Color(0xFF1b1e44),//Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Card(
        //color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormChildren(),
        ),
      ),
    );
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final id = widget.event?.id ?? documentIdFromCurrentDate();
    final storage = Provider.of<StorageService>(context, listen: false);
    File selected = await ImagePicker.pickImage(source: source);
    String url = await storage.uploadEventImage(selected, id);
    setState(() {
      _imageFile = selected;
      _eventImageUrl  = url;
    });
  }

  List<Widget> _buildFormChildren() {


    return [
      TextFormField(

        decoration: new InputDecoration(labelText: 'Full Name',
          fillColor: Colors.white10,
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Title',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _title,
        validator: (value) => value.isNotEmpty ? null : 'Title can\'t be empty',
        onSaved: (value) => _title = value,
      ),
      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'City',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _city,
        //validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _city = value,
      ),
      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Date in DD/MM/YYYY',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _date,
        //validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _date = value,
      ),
      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Duration in hours',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _duration.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
        validator: (value) {
          final isDigitsOnly = int.tryParse(value);
          isDigitsOnly == null ? 'Duration can\'t be empty and digits only': null;
        },
        onSaved: (value) => _duration = int.parse(value),
      ),
      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Describe your event',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        initialValue: _story,
        //validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _story = value,
      ),
      SizedBox(height: 10),
      Container(
        height: 200,
        child: Column(
          children: <Widget>[
            if (_imageFile != null) ...[
              Image.file(_imageFile, height: 100.0, width: 100.0),
            ],
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.photo_library,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                // Spacer(),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    child: RaisedButton(
                      elevation: 7.0,
                      child: Text('Upload an image for your Event'),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      if (_imageFile != null) ...[
        Image.file(_imageFile),
      ]
    ];
  }
}
