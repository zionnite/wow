import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/validator/form_validator.dart';
import 'package:wow/services/ApiService.dart';

class SendMessageBloc extends Object with Validator implements BlocBase {
  final _messName = BehaviorSubject<String>();
  final _messEmail = BehaviorSubject<String>();
  final _messMessage = BehaviorSubject<String>();

  Stream<String> get messNameSinkVal => _messName.transform(nameValidator);
  Stream<String> get messEmailSinkVal => _messEmail.transform(emailValidator);
  Stream<String> get messMessageSinkVal =>
      _messMessage.transform(commentValidator);

  Function(String) get messNameSink => _messName.sink.add;
  Function(String) get messEmailSink => _messEmail.sink.add;
  Function(String) get messMessageSink => _messMessage.sink.add;

  bool commentStatus;

  sendMessage() async {
    commentStatus = await sendPrivateMsg(
      name: _messName.value,
      email: _messEmail.value,
      message: _messMessage.value,
    );

    return commentStatus;
  }

  @override
  void dispose() {
    _messName.close();
    _messEmail.close();
    _messMessage.close();
  }
}
