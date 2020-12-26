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

  /*Per Page*/
  final StreamController<List<Quote>> perPageController =
      BehaviorSubject<List<Quote>>();
  Stream<List<Quote>> get perPageStream => perPageController.stream;

  /*Per Page*/

  List<Quote> data, page_data;
  List<Quote> dataX;
  List<Category> cat_data;
  List<Quote> _list = [];
  QuoteBloc() {
    quotes();
    getCategory();
  }

  quotes() async {
    data = await getAllQuotes();
    _allQuoteController.sink.add(data);
    //perPageController.stream.listen(handleListenPerPage);
    //
  }

  quotePerPage(int perPage) async {
    page_data = await getAllQuotesByPage(perPage);
    // _list = await getAllQuotesByPage(perPage);
    perPageController.sink.add(page_data);
  }

  handleListenPerPage(List<Quote> quote) {
    page_data.addAll(quote);
    perPageController.sink.add(page_data);
  }

  getCategory() async {
    cat_data = await getAllCategory();
    categoryController.sink.add(cat_data);
  }

  getQuoteById(String id) async {
    dataX = await getQuoteByCatId(id);
    listQuoteCatSink.add(dataX);
  }

  void dispose() {
    _allQuoteController.close();
    categoryController.close();
    quoteCatController.close();
    perPageController.close();
  }
}
