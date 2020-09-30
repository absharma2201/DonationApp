import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/CloudDatabase/storageService.dart';
import 'package:iwish_app/Models/donations.dart';
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


class NewDonationPage extends StatefulWidget {
  const NewDonationPage({Key key, this.donation}) : super(key: key);
  final Donation donation;

  static Future<void> show(BuildContext context, {Donation donation}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      Routes.newDonationPage,
      arguments: donation,
    );
  }

  @override
  _NewDonationPageState createState() => _NewDonationPageState();
}

class _NewDonationPageState extends State<NewDonationPage> {
 // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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





  @override
  void initState() {
    super.initState();
    categories = CategoryList.getCategoryList();
    if (widget.donation != null) {
      _description = widget.donation.description;
      _addr = widget.donation.addr;
      _name = widget.donation.name;
      _pincode = widget.donation.pincode;
      _phone = widget.donation.phone;
      _status = widget.donation.status == null ? 'Pending Approval' : widget.donation.status;
      _imageurl = widget.donation.imageurl;
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
        final donations = await database.donationsStream().first;
        final allLowerCaseNames =
        donations.map((donation) => donation.name.toLowerCase()).toList();
        if (widget.donation != null) {
          allLowerCaseNames.remove(widget.donation.name.toLowerCase());
        }
        if (allLowerCaseNames.contains(_name.toLowerCase())) {
          unawaited(showAlertDialog(
            context: context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          ));
        } else {
          final id = widget.donation?.id ?? documentIdFromCurrentDate();
          final time = DateTime.now().microsecondsSinceEpoch;
          final donation = Donation(id: id, name: _name, status: _status, category: selectedcatg.catName,
              description: _description, phone: _phone, pincode: _pincode, addr: _addr,
              imageurl: _imageurl,
              createdAt: time,//DateTime.now().microsecondsSinceEpoch,
              date: DateFormat('yyyy,MM,dd').format(DateTime.fromMicrosecondsSinceEpoch(time)));
          await database.setDonation(donation);

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
        title: Text(widget.donation == null ? 'New Donation' : 'Edit Donation'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.donation == null ? 'Create' : 'Update',
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
    final id = widget.donation?.id ?? documentIdFromCurrentDate();
    final storage = Provider.of<StorageService>(context, listen: false);
    File selected = await ImagePicker.pickImage(source: source);
    String url = await storage.uploadPostImage(selected, id);
    setState(() {
      _imageFile = selected;
      _imageurl  = url;
    });
  }


  List<Widget> _buildFormChildren() {
    return [
      Text('Choose your category of donation:'),
      Column(
        children: createCategoryRadioList(),
      ),
      Divider(
        height: 20,
        color: Colors.green,
      ),
      TextFormField(
        decoration: new InputDecoration(labelText: 'Donation Description',
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
                      child: Text('Upload an approval image document for your donation'),
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