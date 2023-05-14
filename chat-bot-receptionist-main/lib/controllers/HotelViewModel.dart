import 'package:chat_res/model/hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class HotelViewModel extends GetxController {
  static HotelViewModel get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<HotelsModel>> getHotels() async {
    final Snapshot = await _db.collection('Hotels').get();
    final hotelData =
        Snapshot.docs.map((e) => HotelsModel.fromSnapshot((e))).toList();
    return hotelData;
  }
}

