import 'package:chat_res/model/hotel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HotelListView extends StatelessWidget {
  const HotelListView(
      {super.key,
      this.hotelData,
      this.callback,
      required this.animation,
      required this.animationController});

  final HotelsModel? hotelData;
  final Function()? callback;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return InkWell(
          onTap: callback,
          child: FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color.fromARGB(255, 216, 194, 235)
                                .withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 16)
                      ]),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                '${hotelData!.image}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${hotelData!.name}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              const SizedBox(width: 4),
                                              const Icon(
                                                Icons.location_on,
                                                size: 16,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '${hotelData!.location} ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(255, 66, 66, 66).withOpacity(0.8)),
                                              ))
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: <Widget>[
                                                RatingBar(
                                                  ratingWidget: RatingWidget(
                                                    full: const Icon(
                                                        Icons.star_rate_rounded,
                                                        color: Color.fromARGB(
                                                            255,
                                                            196,
                                                            122,
                                                            146)),
                                                    half: const Icon(
                                                      Icons.star_half_rounded,
                                                      color: Color.fromARGB(
                                                          255, 196, 122, 146),
                                                    ),
                                                    empty: const Icon(
                                                      Icons.star_border_rounded,
                                                      color: Color.fromARGB(
                                                          255, 196, 122, 146),
                                                    ),
                                                  ),
                                                  onRatingUpdate: (value) {},
                                                  itemPadding: EdgeInsets.zero,
                                                  initialRating: hotelData!
                                                      .price!
                                                      .toDouble(),
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 24,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${hotelData!.price}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '/per night',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Color.fromARGB(255, 196, 122, 146),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
