import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:iot_urine_tester/controller/result_ctl.dart';
import 'package:iot_urine_tester/model/result_model.dart';
import 'package:iot_urine_tester/view/result_page.dart';
import 'package:load/load.dart';

class FirebaseFunc {
  static final FirebaseDatabase _db = FirebaseDatabase.instance;
  static getData() async {
    showLoadingDialog();
    final _ctl = Get.put(ResultCtl());
    var result = _db.reference().child('result').once();
    result.then((value) {
      var userInfo = ResultModel.fromDb(int.tryParse(value.value));
      _ctl.updateResult(userInfo);
      Get.to(ResultPage());
      hideLoadingDialog();
    });
  }
}
