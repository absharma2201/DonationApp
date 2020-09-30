import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/Models/posts.dart';
import 'package:iwish_app/UIPages/router.dart';
import 'package:provider/provider.dart';

import 'package:pedantic/pedantic.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key key, this.post}) : super(key: key);
  final Post post;

  static Future<void> show(BuildContext context, {Post post}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      Routes.newPostPage,
      arguments: post,
    );
  }

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final _formKey = GlobalKey<FormState>();
  /// Active image file
  File _imageFile;

  String _name;
  String _title;
  String _city;
  String _story;
  String _postImageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _name = widget.post.name;
      _title = widget.post.title;
      _city = widget.post.city;
      _story = widget.post.story;
      _postImageUrl = widget.post.postImageUrl;

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
        final posts = await database.postsStream().first;
        final allLowerCaseNames =
        posts.map((post) => post.name.toLowerCase()).toList();
        if (widget.post != null) {
          allLowerCaseNames.remove(widget.post.name.toLowerCase());
        }

          final id = widget.post?.id ?? documentIdFromCurrentDate();
          final post = Post(id: id, name: _name, title: _title, city: _city,
            story: _story, postImageUrl: _postImageUrl,
          );
          await database.setPost(post);
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
        title: Text(widget.post == null ? 'New Post' : 'Edit Post'),
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
    final id = widget.post?.id ?? documentIdFromCurrentDate();
    final storage = Provider.of<StorageService>(context, listen: false);
    File selected = await ImagePicker.pickImage(source: source);
    String url = await storage.uploadPostImage(selected, id);
    setState(() {
      _imageFile = selected;
      _postImageUrl  = url;
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
        decoration: new InputDecoration(labelText: 'Describe your story',
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
                      child: Text('Upload an image for your Post'),
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