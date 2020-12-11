import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/services/api.dart';
import 'bloc_provider.dart';

class HomescreenBloc implements BlocBase {
  AppApi api = AppApi();
  List<Quote> quoteList = [];

  // final StreamController _quoteListStremeController = StreamController<List<Quote>>();
  final StreamController _quoteListStreamController =
      PublishSubject<List<Quote>>();

  Stream<List<Quote>> get quoteListStream => _quoteListStreamController.stream;
  StreamSink<List<Quote>> get quoteListSink => _quoteListStreamController.sink;

  HomescreenBloc() {
    //_quoteListStreamController.add(quoteList);
    quoteListSink.add(quoteList);
    quoteListStream.listen(_getQuotes);
  }

  _getQuotes(List<Quote> quote) {
    for (int i = 0; i < quote.length; i++) {
      print(quote[i]);
      quoteList.add(quote[i]);
    }
    api.fetchQuote();
  }

  @override
  void dispose() {
    _quoteListStreamController.close();
    // TODO: implement dispose
  }
}
