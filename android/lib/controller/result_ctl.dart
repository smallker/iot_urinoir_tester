import 'package:get/get.dart';
import 'package:iot_urine_tester/model/result_model.dart';

class ResultCtl extends GetxController {
  ResultModel result;

  updateResult(ResultModel _result) {
    result = _result;
    update();
  }
}
