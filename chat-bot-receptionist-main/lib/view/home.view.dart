/*import 'package:chat_res/helper/main.color.dart';
import 'package:chat_res/model/hotel.dart';
import 'package:chat_res/widget/hotel.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_view_model.dart';

class HomeView extends GetWidget<AuthViewModel> {
  HomeView({super.key});
  final AuthViewModel authViewController = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
      appBar: AppBar(
        title: const Text("Atlantis"),
        centerTitle: true,
        backgroundColor: MainColor.mainColor,
      ),
      body: const HotelCardView(hotelsData: [],),
      drawer: Drawer(
          child: ListView(children: [
        DrawerHeader(
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
            Color.fromARGB(255, 101, 3, 118),
            Color.fromARGB(255, 217, 0, 255)
          ]))),
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app_sharp),
          iconColor: Colors.black,
          title: const Text(
            'Exit',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          onTap: () async {
            await controller.signOut();
          },
        ),
      ])),
    )
    );
  }
}

class HotelCardView extends StatelessWidget {
  final List<HotelsModel> hotelsData;
  const HotelCardView({required this.hotelsData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: GridView.builder(
          physics: const ScrollPhysics(),
          itemCount: hotelsData.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return HotelCard(
              hotel: hotelsData[index],
              showDetails: () => Get.to(HomeView),
            );
          },
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 20,
          ),
        ),
      )
    ]);
  }
}*/

import 'dart:ffi';

import 'package:chat_res/controllers/ControlView.dart';
import 'package:chat_res/helper/main.color.dart';
import 'package:chat_res/controllers/HotelViewModel.dart';
import 'package:chat_res/model/hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_view_model.dart';
import '../model/hotel.dart';
import 'details.view.dart';
import 'listView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  AnimationController? animationController;
  List searchResult = [];
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Hotels')
        .where('name', isEqualTo: query)
        .get();
    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ControlView());
    final AuthViewModel authViewController = Get.find<AuthViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Atlantis"),
          centerTitle: true,
          backgroundColor: MainColor.mainColor,
        ),
        drawer: Drawer(
            child: ListView(children: [
          DrawerHeader(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
              Color.fromARGB(255, 101, 3, 118),
              Color.fromARGB(255, 217, 0, 255)
            ]))),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_sharp),
            iconColor: Colors.black,
            title: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () async {
              await authViewController.signOut();
            },
          ),
        ])),
        body: FutureBuilder<List<HotelsModel>>(
            future: controller.gethotelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                          child: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              return Column(
                                children: <Widget>[
                                  getSearchBarUI(),
                                  getTimeDateUI()
                                ],
                              );
                            }, childCount: 1)),
                            SliverPersistentHeader(
                                delegate: ContestTabHeader(getFilterBarUI()))
                          ];
                        },
                        body: Container(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final int count = snapshot.data!.length > 10
                                  ? 10
                                  : snapshot.data!.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController!.forward();
                              return HotelListView(
                                callback: () {
                                  Get.to(DetailsView(
                                      model: snapshot.data![index]));
                                },
                                hotelData: snapshot.data![index],
                                animation: animation,
                                animationController: animationController!,
                              );
                            },
                            itemCount: snapshot.data!.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text('Somthing went wrong'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

getSearchBarUI() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(14, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(38.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0)
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              child: TextField(
                style: const TextStyle(
                  fontSize: 18,
                ),
                cursorColor: Color.fromARGB(255, 145, 28, 180),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "search...."),
              ),
            ),
          ),
        )),
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 145, 28, 180),
              borderRadius: BorderRadius.all(Radius.circular(38.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0)
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              onTap: () {
                
              },
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.search,
                    size: 26,
                    color: Colors.white,
                  )),
            ),
          ),
        )
      ],
    ),
  );
}

getTimeDateUI() {
  return Padding(
    padding: const EdgeInsets.only(left: 18, bottom: 16),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Row(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Choose Date",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              Color.fromARGB(255, 73, 73, 73).withOpacity(0.8)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${DateFormat('dd, MMM').format(DateTime.now())} - ${DateFormat('dd, MMM').format(DateTime.now().add(const Duration(days: 5)))}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: 1,
            height: 42,
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
        Expanded(
            child: Row(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Number of Rooms',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color:
                              Color.fromARGB(255, 70, 69, 69).withOpacity(0.8)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1 Room - 2 Adults',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ))
      ],
    ),
  );
}

getFilterBarUI() {
  return Stack(
    children: <Widget>[
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
          )),
      Container(
        color: Colors.transparent,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Filter',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.sort,
                          size: 30,
                          color: Color.fromARGB(255, 145, 28, 180),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  final Widget searchUI;
  ContestTabHeader(this.searchUI);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

