import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wow/blocs/send_message_bloc.dart';
import 'package:wow/utils.dart';
import 'package:wow/widget/app_title_widget.dart';

import '../bottom_navigation.dart';

class SendPrivateMessage extends StatefulWidget {
  static const String id = 'send_private_message';
  @override
  _SendPrivateMessageState createState() => _SendPrivateMessageState();
}

class _SendPrivateMessageState extends State<SendPrivateMessage> {
  final sendMsgBloc = SendMessageBloc();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool _isLoading = false;
  bool _showStatus = false;
  bool _showCommentStatus;
  String _statusMsg;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              appTitleWidget(
                title: 'Send Private Message',
                toNav: Nav.id,
              ),
              (_showStatus == true)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        _statusMsg,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: StreamBuilder<String>(
                    stream: sendMsgBloc.messNameSinkVal,
                    builder: (context, snapshot) => TextField(
                      onChanged: sendMsgBloc.messNameSink,
                      controller: fullNameController,
                      style: dropDownMenuItemStyle,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 18.0),
                        border: InputBorder.none,
                        hintText: 'Your Name',
                        errorText: snapshot.error,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: StreamBuilder<String>(
                    stream: sendMsgBloc.messEmailSinkVal,
                    builder: (context, snapshot) => TextField(
                      onChanged: sendMsgBloc.messEmailSink,
                      controller: emailController,
                      style: dropDownMenuItemStyle,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 18.0),
                        border: InputBorder.none,
                        hintText: 'Email Address',
                        errorText: snapshot.error,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                child: Container(
                  height: 300.0,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: StreamBuilder<String>(
                      stream: sendMsgBloc.messMessageSinkVal,
                      builder: (context, snapshot) => TextField(
                        onChanged: sendMsgBloc.messMessageSink,
                        maxLines: null,
                        controller: messageController,
                        style: dropDownMenuItemStyle,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 18.0),
                          border: InputBorder.none,
                          hintText: 'Enter Message',
                          errorText: snapshot.error,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  if (fullNameController.text.length > 5 &&
                      emailController.text.contains("@") &&
                      messageController.text.length > 10) {
                    _showCommentStatus = await sendMsgBloc.sendMessage();
                    if (_showCommentStatus) {
                      setState(() {
                        new Future.delayed(new Duration(seconds: 4), () {
                          _showStatus = true;
                          _statusMsg = 'Message has been Sent successfully!';
                        });
                      });
                    } else {
                      setState(() {
                        new Future.delayed(new Duration(seconds: 4), () {
                          _showStatus = true;
                          _statusMsg =
                              'Could not add Send Message, please try again later or contact admin if issue persist!';
                        });
                      });
                    }

                    new Future.delayed(new Duration(seconds: 4), () {
                      setState(() {
                        _isLoading = false;
                        fullNameController.text = '';
                        emailController.text = '';
                        messageController.text = '';
                      });
                    });
                  } else {
                    setState(() {
                      _isLoading = false;
                      _showStatus = true;
                      _statusMsg =
                          'All Information is needed, Please fill the form';
                    });
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(250),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 50),
                    child: Text(
                      'Send Message',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  elevation: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
