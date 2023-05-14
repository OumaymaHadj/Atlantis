import 'package:cloud_firestore/cloud_firestore.dart';

class HotelsModel {
  String? name, stars, image, location;
  int? price ;
  String? description ;
  HotelsModel(
      {this.name,
      this.stars,
      this.price,
      this.description,
      this.image,
      this.location});
  factory HotelsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return HotelsModel(
      name: data['name'],
      price: data['price'],
      stars: data['stars'],
      description: data['description'],
      image: data['image'],
      location: data['location'],
    );
  }

  toJson() {
    return {
      'name': name,
      'stars': stars,
      'price': price,
      'description': description,
      'location': location,
      'image': image
    };
  }
}
