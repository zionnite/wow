import 'dart:async';

import 'package:wow/model/Quote.dart';
import 'package:wow/services/QuoteService.dart';

class QuoteBloc {
  final _allQuoteController = StreamController<List<Quote>>.broadcast();
  Stream<List<Quote>> get allQuoteStream => _allQuoteController.stream;
  StreamSink<List<Quote>> get allQuoteSink => _allQuoteController.sink;

  List<Quote> data;
  QuoteBloc() {
    quotes();
  }
  quotes() async {
    data = await getAllQuotes();
    _allQuoteController.sink.add(data);
  }

  void dispose() {
    _allQuoteController.close();
  }
}
