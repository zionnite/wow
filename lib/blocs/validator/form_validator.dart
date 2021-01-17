import 'dart:async';

import 'dart:io';

mixin Validator {
  var nameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (formNameInput, sink) {
    if (formNameInput.length > 5) {
      sink.add(formNameInput);
    } else {
      sink.addError("Invalid Name, Full name too short or must not be empty!");
    }
  });

  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError("Email is not Valid");
    }
  });

  var titleValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (formTitleInput, sink) {
    if (formTitleInput.length > 10) {
      sink.add(formTitleInput);
    } else {
      sink.addError("Invalid Title, Title must not be empty or less than 10!");
    }
  });

  var contentValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (formContentInput, sink) {
    if (formContentInput.length > 50) {
      sink.add(formContentInput);
    } else {
      sink.addError(
          "Invalid Content, Content must not be empty or less than 50!");
    }
  });

  var commentValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (formContentInput, sink) {
    if (formContentInput.length > 10) {
      sink.add(formContentInput);
    } else {
      sink.addError(
          "Invalid Content, Content must not be empty or less than 10!");
    }
  });

  var postImageValidator =
      StreamTransformer<File, File>.fromHandlers(handleData: (postImage, sink) {
    if (postImage != null) {
      sink.add(postImage);
    } else {
      sink.addError("Post Image not Selected!");
    }
  });

  var profileImageValidator = StreamTransformer<File, File>.fromHandlers(
      handleData: (profileImage, sink) {
    if (profileImage != null) {
      sink.add(profileImage);
    } else {
      sink.addError("Profile Image not Selected!");
    }
  });
}
