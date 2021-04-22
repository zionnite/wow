import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Category.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/services/ApiService.dart';

class QuoteBloc implements BlocBase {
  final StreamController<List<Quote>> _allQuoteController =
      BehaviorSubject<List<Quote>>();
  Stream<List<Quote>> get allQuoteStream => _allQuoteController.stream;

  final StreamController<List<Category>> categoryController =
      BehaviorSubject<List<Category>>();
  Stream<List<Category>> get categoryStream => categoryController.stream;

  final StreamController<List<Quote>> quoteCatController =
      BehaviorSubject<List<Quote>>();
  StreamSink<List<Quote>> get listQuoteCatSink => quoteCatController.sink;
  Stream<List<Quote>> get listQuoteCatStream => quoteCatController.stream;

  final StreamController<List<Quote>> randomQuoteController =
      BehaviorSubject<List<Quote>>();
  StreamSink<List<Quote>> get listRandomQuoteSink => randomQuoteController.sink;
  Stream<List<Quote>> get listRandomQuoteStream => randomQuoteController.stream;

  /*Per Page*/
  final StreamController<List<Quote>> perPageController =
      BehaviorSubject<List<Quote>>();
  Stream<List<Quote>> get perPageStream => perPageController.stream;

  final StreamController<int> yesCounterController = BehaviorSubject<int>();
  StreamSink<int> get yerCounterSink => yesCounterController.sink;
  Stream<int> get yesCounterStream => yesCounterController.stream;

  final StreamController<int> noCounterController = BehaviorSubject<int>();
  StreamSink<int> get noCounterSink => noCounterController.sink;
  Stream<int> get noCounterStream => noCounterController.stream;
  /*Per Page*/

  int yes_counter;
  int no_counter;
  List<Quote> data, page_data, dataX, random_data;
  List<Category> cat_data;
  QuoteBloc() {
    quotes();
    getCategory();
    randomQuote();
  }

  quotes() async {
    data = await getAllQuotes();
    _allQuoteController.sink.add(data);
  }

  /*Quote Screen*/
  quotePerPage(int perPage) async {
    page_data = await getAllQuotesByPage(perPage);
    perPageController.sink.add(page_data);
  }

  handleListenPerPage(List<Quote> quote) {
    page_data.addAll(quote);
    perPageController.sink.add(page_data);
  }

  handleListenRefresh(List<Quote> quote) {
    page_data.clear();
    page_data.addAll(quote);
    perPageController.sink.add(quote);
  }
  /*Quote Screen*/

  randomQuote() async {
    random_data = await getRandomQuote();
    randomQuoteController.sink.add(random_data);
  }

  getCategory() async {
    cat_data = await getAllCategory();
    categoryController.sink.add(cat_data);
  }

  /*Quote Category Screen*/

  getQuoteById(String id, int current_page) async {
    dataX = await getQuoteByCatId(id, current_page);
    listQuoteCatSink.add(dataX);
  }

  handleCatListenPerPage(List<Quote> quote) {
    dataX.addAll(quote);
    listQuoteCatSink.add(dataX);
  }

  handleCatRefresh(List<Quote> quote) {
    dataX.clear();
    dataX.addAll(quote);
    listQuoteCatSink.add(dataX);
  }

  handleYesCounter(String id, int current_counter, String user) async {
    yes_counter = await getQuoteYesCounter(id, current_counter, user);
    yerCounterSink.add(yes_counter);
    return yes_counter;
  }

  handleNoCounter(String id, int current_counter, String user) async {
    no_counter = await getQuoteNoCounter(id, current_counter, user);
    noCounterSink.add(no_counter);
    return no_counter;
  }
  /*Quote Category Screen*/

  void dispose() {
    _allQuoteController.close();
    randomQuoteController.close();
    categoryController.close();
    quoteCatController.close();
    perPageController.close();
    yesCounterController.close();
  }
}
