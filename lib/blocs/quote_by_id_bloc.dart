import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:wow/model/model_response/quote_response.dart';
import 'package:wow/repository/quote_repository.dart';

class QuoteListByIdBloc{
  final QuoteRepository _quoteRepository  = QuoteRepository();
  final BehaviorSubject<QuoteResponse> _subject = BehaviorSubject<QuoteResponse>();

  getQuoteById(int id) async{
    QuoteResponse response = await  _quoteRepository.getQuotePostById(id);
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

  BehaviorSubject<QuoteResponse> get subject => _subject;
}
final quoteByIdBloc = QuoteListByIdBloc();