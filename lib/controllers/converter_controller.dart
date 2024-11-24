import 'package:get/get.dart';
import 'package:ring_sizer/config/constants.dart';

class ConverterController extends GetxController {
  static ConverterController get instance => Get.find();

  // Ring size chart
  final List<List<dynamic>> ringChart = [
    //DIAMETER(MM),USA, UK
    [12.37, '1', 'B'],
    [13.2, '2', 'D'],
    [13.7, '2 1/2', 'E'],
    [14.0, '3', 'F'],
    [14.4, '3 1/2', 'G'],
    [14.7, '3 3/4', 'G 1/2'],
    [15.0, '4', 'H 1/2'],
    [15.4, '4 1/2', 'I 1/2'],
    [15.7, '5', 'J 1/2'],
    [16.0, '5 1/2', 'K 1/2'],
    [16.4, '5 3/4', 'L'],
    [16.7, '6', 'L 1/2'],
    [17.0, '6 1/2', 'M 1/2'],
    [17.4, '7', '0'],
    [17.7, '7 1/2', 'P'],
    [18.0, '8', 'Q'],
    [18.4, '8 1/2', 'R'],
    [18.7, '9', 'S'],
    [19.4, '10', 'T 1/2'],
    [19.7, '10 1/4', 'U'],
    [20.0, '10 1/2', 'U 1/2'],
    [20.4, '11', 'V 1/2'],
    [20.7, '11 1/2', 'W 1/2'],
    [21.0, '12', 'Y'],
    [21.4, '12 1/2', 'Z'],
    [21.7, '13', 'Z 1/2'],
  ];

  @override
  void onInit() {
    super.onInit();
    ringSizeList = ringChart.map((ring) => ring[1].toString()).toList();
    selectedSize = ringSizeList.first;
  }

  // Variables
  final RxString _from = US.obs;
  final RxString _to = AUUK.obs;
  final RxString _selectedSize = ''.obs;
  final RxString _convertSize = ''.obs;

  final RxList<String> _ringSizeList = <String>[].obs;

  // Getters
  String get from => _from.value;
  String get to => _to.value;
  String get selectedSize => _selectedSize.value;
  String get convertSize => _convertSize.value;

  List<String> get ringSizeList => _ringSizeList;

  // Setters
  set from(String value) => _from.value = value;
  set to(String value) => _to.value = value;
  set selectedSize(String value) => _selectedSize.value = value;
  set convertSize(String value) => _convertSize.value = value;

  set ringSizeList(List<String> value) => _ringSizeList.value = value;

  // Functions
  void toggleVariable() {
    String temp = to;
    to = from;
    from = temp;

    if (from == US && to == AUUK) {
      ringSizeList = ringChart.map((ring) => ring[1].toString()).toList();
      selectedSize = ringSizeList.first;
    }
    if (from == AUUK && to == US) {
      ringSizeList = ringChart.map((ring) => ring[2].toString()).toList();
      selectedSize = ringSizeList.first;
    }
  }

  void convertRingSize() {
    if (from == US && to == AUUK) {
      convertSize = ringChart.firstWhere((ring) => ring[1] == selectedSize)[2];
    }
    if (from == AUUK && to == US) {
      convertSize = ringChart.firstWhere((ring) => ring[2] == selectedSize)[1];
    }
  }

  bool isRingFloatValue() {
    return convertSize.split(' ').length > 1;
  }

  String getRingFirstValue() {
    return convertSize.split(' ')[0];
  }

  String? getRingSecondValue() {
    if (isRingFloatValue()) {
      return convertSize.split(' ')[1];
    }
    return null;
  }
}
