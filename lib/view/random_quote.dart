import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db_miner/controller/random_quote_controller.dart';

import '../../modal/db_helper.dart';

class RandomQuotePage extends StatefulWidget {
  const RandomQuotePage({super.key});

  @override
  State<RandomQuotePage> createState() => _RandomQuotePageState();
}

RandomQuoteController randomQuoteController = Get.put(RandomQuoteController());

class _RandomQuotePageState extends State<RandomQuotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random Quotes"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            color: Colors.grey,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: ListView.builder(
                  itemCount: randomQuoteController.random.length,
                  itemBuilder: (BuildContext context, int index) {
                    var sample = randomQuoteController.random[index];
                    randomQuoteController.quote.value = "${sample.content}";
                    print("DATA===");
                    print(sample.content);
                    randomQuoteController.cIndex = index;
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Obx(() =>
                                  Text("${randomQuoteController.quote.value}")),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    randomQuoteController.getApiData();
                  },
                  child: Text("Fetch New"),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                    onPressed: () async {
                      var sample = randomQuoteController
                          .random[randomQuoteController.cIndex];
                      DbHelper.instance.insertData("${sample.content}");
                      addToFavorites("${sample.content}");
                    },
                    child: Text("Add To Favorite")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addToFavorites(String quote) async {
    bool added = await DbHelper.instance.insertData(quote);
    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quote added to favorites'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quote is already in favorites'),
        ),
      );
    }
  }
}
