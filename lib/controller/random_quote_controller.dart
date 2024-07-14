import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../modal/q_model.dart';


class RandomQuoteController extends GetxController {
  List<RandomQuote> random = [];
  int cIndex = 0;
  RxString quote = "".obs;
  RxString author = "".obs;

  void onInit() {
    super.onInit();
    getApiData();
  }

  void getApiData() async {
    var quoteapi =
    await http.get(Uri.parse("w"));
    if (quoteapi.statusCode == 200) {
      random = randomQuoteFromJson(quoteapi.body);
      if (random.isNotEmpty) {
        quote.value = random[0].content!;
        author.value = random[0].author!;
        update();
        print("LENGTH==> ${random.length}");
      }
    } else {
      print("Failed to fetch data: ${quoteapi.statusCode}");
    }
  }

}