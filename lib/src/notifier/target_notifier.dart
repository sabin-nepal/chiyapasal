import 'package:chiyapasal/src/services/other_service.dart';
import 'package:flutter/cupertino.dart';

class TargetNotifier extends ChangeNotifier {
  dynamic _target;

  dynamic get target => _target;

  TargetNotifier() {
    getTartget();
    notifyListeners();
  }

  getTartget() async {
    _target = await OtherService().fetchTarget();
    notifyListeners();
  }

  Future setTarget({required int product, required int stock}) async {
    await OtherService().saveTarget(product: product, stock: stock);
    _target = {
      'product': product,
      'stock': stock,
    };
    notifyListeners();
  }
}
