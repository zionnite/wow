import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:wow/model/model_response/forum_response.dart';
import 'package:wow/repository/quote_repository.dart';

class ForumListByIdBloc{
  final QuoteRepository _quoteRepository  = QuoteRepository();
  final BehaviorSubject<ForumResponse> _subject = BehaviorSubject<ForumResponse>();

  getForumById(int id) async{
    ForumResponse response = await  _quoteRepository.getForumPostById(id);
    _subject.sink.add(response);
  }



  void drainStream(){
    _subject.value =null;
  }

  @mustCallSuper
  dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ForumResponse> get subject => _subject;
}
final forumByIdBloc = ForumListByIdBloc();