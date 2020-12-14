import 'dart:async';

import 'package:wow/model/Quote.dart';
import 'package:wow/services/QuoteService.dart';

class QuoteBloc {
  final _allQuoteController = StreamController<List<Quote>>();
  Stream<List<Quote>> get allQuoteStream => _allQuoteController.stream;
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
