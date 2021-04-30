import 'package:wow/model/authModel.dart';

abstract class LoginPresenter {
  void onSuccess({
    String systemId,
    String userId,
    String fullName,
    String age,
    String sex,
    String email,
    String phoneNo,
    String userImg,
    String status,
    String status_msg,
  });
  // void onSuccess(AuthModel authModel);

  void onError(String error);

  void displayMessage(String status, String message);
}
