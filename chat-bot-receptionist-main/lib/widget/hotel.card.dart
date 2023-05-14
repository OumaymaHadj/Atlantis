//import 'package:chat_res/model/hotel.dart';
//import 'package:flutter/material.dart';

/*class HotelCard extends StatelessWidget {
  final HotelsModel hotel;
  final Function() showDetails;
  const HotelCard({required this.hotel, required this.showDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: showDetails,
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Image.network(hotel.image, fit: BoxFit.cover),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotel.title,
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 4),
                      Text(hotel.location,
                          style: Theme.of(context).textTheme.caption),
                      const SizedBox(height: 8),
                      Text('\$${hotel.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
              ),
            ],
          ),
        )
      );
  }
}*/
