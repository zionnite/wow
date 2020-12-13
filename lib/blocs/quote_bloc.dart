import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/model/model_response/quote_response.dart';
import 'package:wow/repository/quote_repository.dart';

// class QuoteListBloc {
//   final QuoteRepository _quoteRepository = QuoteRepository();
//   final BehaviorSubject<QuoteResponse> _subject =
//       BehaviorSubject<QuoteResponse>();
//
//   getQuotes() async {
//     QuoteResponse response = await _quoteRepository.getQuotePost();
//     _subject.sink.add(response);
//   }
//
//   dispose() {
//     _subject.close();
//   }
//
//   BehaviorSubject<QuoteResponse> get subject => _subject;
// }
//
// final quoteBloc = QuoteListBloc();

class QuoteList_Bloc {
  final QuoteRepository _quoteRepository = QuoteRepository();
  QuoteResponse _list;
  final StreamController _quoteListStreamController =
      StreamController<QuoteResponse>();
  // final StreamController _quoteListStreamController =
  //     StreamController<QuoteResponse>.broadcast();
  StreamSink<QuoteResponse> get quoteSink => _quoteListStreamController.sink;
  Stream<QuoteResponse> get quoteStream => _quoteListStreamController.stream;

  QuoteList_Bloc() {
    _quoteListStreamController.add(_list);
    quoteStream.listen(_getListBloc);
  }
  _getListBloc(QuoteResponse Response) async {
    QuoteResponse response = await _quoteRepository.getQuotePost();
    quoteSink.add(response);
  }

  void dispose() {
    _quoteListStreamController.close();
  }
}
