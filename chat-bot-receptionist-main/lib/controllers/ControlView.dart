import 'package:chat_res/controllers/HotelViewModel.dart';
import 'package:chat_res/model/hotel.dart';
import 'package:chat_res/view/home.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/login.view.dart';
import 'auth_view_model.dart';


class ControlView extends GetxController {
  static ControlView get instance => Get.find();
  final _hotelRepo = Get.put (HotelViewModel());
  final _authRepo = Get.put(AuthViewModel());

  Future <List<HotelsModel>> gethotelData ()async {
    return await _hotelRepo.getHotels();
  }
} 

