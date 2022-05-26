import 'package:fluttertoast/fluttertoast.dart';

extension EToastUtil on String {
  show() {
    Fluttertoast.showToast(msg: this, gravity: ToastGravity.CENTER);
  }
}

Toast TOAST_LENGTH_SHORT = Toast.LENGTH_SHORT;
Toast TOAST_LENGTH_LONG = Toast.LENGTH_LONG;

showToast(String msg, {Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      fontSize: 18,
      toastLength: toastLength);
}

cancelToast() {
  Fluttertoast.cancel();
}
