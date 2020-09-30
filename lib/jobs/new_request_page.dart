import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/Models/requests.dart';
import 'package:iwish_app/UIPages/router.dart';
import 'package:provider/provider.dart';

import 'package:pedantic/pedantic.dart';
import 'package:intl/intl.dart';

class CategoryList {
  CategoryList({this.catId, this.catName, this.catIcon});

  int catId;
  String catName;
  String catIcon;

  static List<CategoryList> getCategoryList() {
    return <CategoryList>[
      CategoryList(catId: 1, catName: "Books", catIcon: "Icons"),
      CategoryList(catId: 2, catName: "Art&Craft", catIcon: "Icons"),
      CategoryList(catId: 3, catName: "Music", catIcon: "Icons"),
      CategoryList(catId: 4, catName: "Sports", catIcon: "Icons"),
      CategoryList(catId: 5, catName: "MachineTools", catIcon: "Icons"),
    ];
  }

}


class NewRequestPage extends StatefulWidget {
  const NewRequestPage({Key key, this.request}) : super(key: key);
  final Request request;

  static Future<void> show(BuildContext context, {Request request}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      Routes.newRequestPage,
      arguments: request,
    );
  }

  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  final _formKey = GlobalKey<FormState>();
  List<CategoryList> categories;
  CategoryList selectedcatg;
  File _imageFile;

/*
 this.id, @required this.name, @required this.status, this.createdAt,
        this.date, this.category, this.addr, this.description, this.pincode, this.imageurl,
        this.phone,
 */
  String _description;
  String _addr;
  String _name;
  int _pincode;
  int _phone;
  String _status;
  String _imageurl;
  Geolocator geolocator = Geolocator();
  GeoPoint geo;
  Position userLocation;




  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
    categories = CategoryList.getCategoryList();
    if (widget.request != null) {
      _description = widget.request.description;
      _addr = widget.request.addr;
      _name = widget.request.name;
      _pincode = widget.request.pincode;
      _phone = widget.request.phone;
      _status = widget.request.status == null ? 'Pending Approval' : widget.request.status;
      _imageurl = widget.request.imageurl;
    }
  }



  setSelectedCat(CategoryList cat) {
    setState(() {
      selectedcatg = cat;
    });
  }

  List<Widget> createCategoryRadioList() {
    List<Widget> widgets = [];
    for (CategoryList catg in categories) {
      widgets.add(
        RadioListTile(
          value: catg,
          groupValue: selectedcatg,
          title: Text(catg.catName),
          onChanged: (currentCat) {
            setSelectedCat(currentCat);
          },
          selected: selectedcatg == catg,
          activeColor: Colors.green,
        ),

      );
    }
    return widgets;
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
        final requests = await database.requestsPStream().first;
        final allLowerCaseNames =
        requests.map((request) => request.name.toLowerCase()).toList();
        if (widget.request != null) {
          allLowerCaseNames.remove(widget.request.name.toLowerCase());
        }
        if (allLowerCaseNames.contains(_name.toLowerCase())) {
          unawaited(showAlertDialog(
            context: context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          ));
        } else {
          final id = widget.request?.id ?? documentIdFromCurrentDate();
          final time = DateTime.now().microsecondsSinceEpoch;
          geo = new GeoPoint(userLocation.latitude, userLocation.longitude);
          final request = Request(id: id, name: _name, status: _status, category: selectedcatg.catName,
              description: _description, phone: _phone, pincode: _pincode, addr: _addr,
              imageurl: _imageurl, geoloc: geo,
              createdAt: time,//DateTime.now().microsecondsSinceEpoch,
              date: DateFormat('yyyy,MM,dd').format(DateTime.fromMicrosecondsSinceEpoch(time)));
          await database.setRequest(request);
          Navigator.of(context).pop();
        }
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
    //  print (readTimestamp(DateTime.now().toIso8601String()));
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.request == null ? 'New Request' : 'Edit Request'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.request == null ? 'Create' : 'Update',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final id = widget.request?.id ?? documentIdFromCurrentDate();
    final storage = Provider.of<StorageService>(context, listen: false);
    File selected = await ImagePicker.pickImage(source: source);
    String url = await storage.uploadPostImage(selected, id);
    setState(() {
      _imageFile = selected;
      _imageurl  = url;
    });
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  List<Widget> _buildFormChildren() {
    return [
      Text('Choose your category of request:'),
      Column(
        children: createCategoryRadioList(),
      ),
      Divider(
        height: 20,
        color: Colors.green,
      ),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Request Description',
          fillColor: Colors.white10,
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        maxLines: 3,
        initialValue: _description,
        validator: (value) => value.isNotEmpty ? null : 'Description can\'t be empty',
        onSaved: (value) => _description = value,
      ),
      SizedBox(height: 5,),

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
        decoration: new InputDecoration(labelText: 'Address',
          fillColor: Colors.white10,
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _addr,
        validator: (value) => value.isNotEmpty ? null : 'Address can\'t be empty',
        onSaved: (value) => _addr = value,
      ),
      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Pincode',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _pincode.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
        validator: (value)  {
          final isDigitsOnly = int.tryParse(value);
          isDigitsOnly == null ? 'Pincode can\'t be empty and digits only': null;
        },
        onSaved: (value) => _pincode = int.parse(value),
      ),
      SizedBox(height: 5,),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Phone Number',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(
            ),
          ),
        ),
        keyboardAppearance: Brightness.light,
        initialValue: _phone.toString(),
        keyboardType: TextInputType.phone,
        inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
        validator: (value) {
          final isDigitsOnly = int.tryParse(value);
          isDigitsOnly == null ? 'Phone Number can\'t be empty and digits only': null;
    },
        onSaved: (value) => _phone = int.parse(value),
      ),
      SizedBox(height: 5,),
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
                      child: Text('Upload an approval image document for your request'),
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