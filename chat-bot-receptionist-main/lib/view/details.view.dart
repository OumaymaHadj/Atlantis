import 'package:chat_res/view/chatBot.dart';
import 'package:flutter/material.dart';

import '../model/hotel.dart';

class DetailsView extends StatelessWidget {
  DetailsView({Key? key, this.model}) : super(key: key);
  HotelsModel? model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: size.height * 0.38,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Image.network(
                      model!.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(15)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model!.name!,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 145, 28, 180),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      model!.location!,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      child: Text(
                        model!.price!.toString() + 'TDN',
                        style: TextStyle(
                            color: Color.fromARGB(255, 145, 28, 180),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  child: Text(
                    model!.description!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatBotView()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color.fromARGB(255, 145, 28, 180),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 8.0,
                ),
              ),
              child: const Text("To Book"),
            )
          ],
        ),
      ),
    );
  }
}
