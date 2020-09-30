import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/Models/enquiry.dart';
import 'package:iwish_app/UIPages/router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';

class NewEnquiryPage extends StatefulWidget {
  const NewEnquiryPage({Key key, this.enquiry}) : super(key: key);
  final Enquiry enquiry;

  static Future<void> show(BuildContext context, {Enquiry enquiry}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      Routes.newEnquiryPage,
      arguments: enquiry,
    );
  }

  @override
  _NewEnquiryPageState createState() => _NewEnquiryPageState();
}

class _NewEnquiryPageState extends State<NewEnquiryPage> {
  final _formKey = GlobalKey<FormState>();
  /// Active image file
  File _imageFile;

  String _name;
  String _title;
  String _description;
  String _enquiryImageUrl;
  String _reply;

  @override
  void initState() {
    super.initState();
    if (widget.enquiry != null) {
      _name = widget.enquiry.name;
      _title = widget.enquiry.title;
      _description = widget.enquiry.description;
      _enquiryImageUrl = widget.enquiry.imageurl;
      _reply =  widget.enquiry.reply;
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
        final enquiries = await database.enquiryStream().first;
        final allLowerCaseNames =
        enquiries.map((enquiry) => enquiry.name.toLowerCase()).toList();
        if (widget.enquiry != null) {
          allLowerCaseNames.remove(widget.enquiry.name.toLowerCase());
        }

        final id = widget.enquiry?.id ?? documentIdFromCurrentDate();
        final time = DateTime.now().microsecondsSinceEpoch;
        final enquiry = Enquiry(id: id, name: _name, title: _title, reply: _reply,
          description: _description, imageurl: _enquiryImageUrl,
            createdAt: time,//DateTime.now().microsecondsSinceEpoch,
            date: DateFormat('yyyy,MM,dd').format(DateTime.fromMicrosecondsSinceEpoch(time)));
        await database.setEnquiry(enquiry);
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
        title: Text(widget.enquiry == null ? 'New Enquiry' : 'Edit Enquiry'),
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
    final id = widget.enquiry?.id ?? documentIdFromCurrentDate();
    final storage = Provider.of<StorageService>(context, listen: false);
    File selected = await ImagePicker.pickImage(source: source);
    String url = await storage.uploadEnquiryImage(selected, id);
    setState(() {
      _imageFile = selected;
      _enquiryImageUrl  = url;
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
        decoration: new InputDecoration(labelText: 'Subject',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _title,
        validator: (value) => value.isNotEmpty ? null : 'Subject can\'t be empty',
        onSaved: (value) => _title = value,
      ),
      SizedBox(height: 5,),

      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Describe your enquiry',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        initialValue: _description,
        //validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _description = value,
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
                      child: Text('Upload an image for your Enquiry'),
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