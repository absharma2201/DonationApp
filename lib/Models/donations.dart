
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class Donation {
  const Donation(
      {@required this.id, @required this.name, @required this.status, this.createdAt,
        this.date, this.category, this.addr, this.description, this.pincode, this.imageurl,
        this.phone,
      });

  final String id;
  final String category;
  final String description;
  final String name;
  final String addr;
  final int pincode;
  final int phone;

  final String status;
  final int createdAt;
  final String date;
  final String imageurl;


  factory Donation.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String category =  data['category'];
    final String description =  data['description'];
    final String name = data['name'];
    final String addr =  data['addr'];
    final int pincode =  data['pincode'];
    final String status = data['status'];
    final int createdAt = data['createdAt'];
    final String date =  data['date'];
    final String imageurl =  data['imageurl'];
    final int phone = data['phone'];
    return Donation(id: documentId, name: name, category: category, status: status,
        description: description, addr: addr, pincode: pincode, imageurl: imageurl,
        createdAt: createdAt, date: date, phone: phone);
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'name': name,
      'status': status,
      'createdAt': createdAt,
      'date': date,
      'description': description,
      'addr': addr,
      'pincode': pincode,
      'imageurl': imageurl,
      'phone': phone,
    };
  }

  @override
  int get hashCode => hashValues(id, name, status, createdAt, category, imageurl, phone, description);

  /*
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Donation otherDonation = other;
    return id == otherDonation.id &&
        name == otherDonation.name &&
        status == otherDonation.status &&
        createdAt == otherDonation.createdAt &&
        date == otherDonation.date;
  }

   */

  @override
  String toString() => 'id: $id, name: $name, phone: $phone'
      'category: $category, description: $description, addr: $addr, pincode: $pincode, imageurl: $imageurl'
      'status: $status, createdAt: $createdAt, date: $date';
}