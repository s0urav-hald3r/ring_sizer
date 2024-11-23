import 'package:get/get.dart';

class RingController extends GetxController {
  static RingController get instance => Get.find();

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
    division = ringChart.length;
    initialValue = division ~/ 2;
    currentValue = division ~/ 2;
    updateDiameter();
  }

  // Variables
  final RxInt _division = 0.obs;
  final RxInt _initialValue = 0.obs;
  final RxInt _currentValue = 0.obs;
  final RxDouble _dpi = 0.0.obs;
  final RxDouble _diameterInPx = 0.0.obs;

  // Getters
  int get division => _division.value;
  int get initialValue => _initialValue.value;
  int get currentValue => _currentValue.value;
  double get dpi => _dpi.value;
  double get diameterInPx => _diameterInPx.value;

  // Setters
  set division(int value) => _division.value = value;
  set initialValue(int value) => _initialValue.value = value;
  set currentValue(int value) => _currentValue.value = value;
  set dpi(double value) => _dpi.value = value;
  set diameterInPx(double value) => _diameterInPx.value = value;

  // update diameter based on slider value
  void updateDiameter() {
    /// [Convert diameter from mm to logical pixels]

    double diameter = ringChart[currentValue][0];

    diameterInPx = (100 / 14) * diameter;
  }

  void increment() {
    if (currentValue > ringChart.length) return;

    currentValue++;
    updateDiameter();
  }

  void decrement() {
    if (currentValue == 0) return;

    currentValue--;
    updateDiameter();
  }

  bool isUSFloatValue() {
    return ringChart[currentValue][1].split(' ').length > 1;
  }

  String getUSFirstValue() {
    return ringChart[currentValue][1].split(' ')[0];
  }

  String getUSSecondValue() {
    return ringChart[currentValue][1].split(' ')[1];
  }

  String getUSValue() {
    return ringChart[currentValue][1].toString();
  }

  String getUKValue() {
    return ringChart[currentValue][2].toString();
  }

  String getInch() {
    return (ringChart[currentValue][0] / 25.4).toStringAsFixed(2);
  }

  String getCemi() {
    return (ringChart[currentValue][0] / 10).toStringAsFixed(2);
  }
}
