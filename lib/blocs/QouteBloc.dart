import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/services/ApiService.dart';

class QuoteBloc implements BlocBase {
  final StreamController<List<Quote>> _allQuoteController =
      BehaviorSubject<List<Quote>>();
  Stream<List<Quote>> get allQuoteStream => _allQuoteController.stream;
  List<Quote> data;

  QuoteBloc() {
    quotes();
  }
  quotes() async {
    data = await getAllQuotes();
    _allQuoteController.sink.add(data);
    //
  }

  void dispose() {
    _allQuoteController.close();
  }
}
