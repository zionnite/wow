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
      StreamController<List<Quote>>();
  StreamSink<List<Quote>> get listQuoteCatSink => quoteCatController.sink;
  Stream<List<Quote>> get listQuoteCatStream => quoteCatController.stream;

  List<Quote> data;
  List<Quote> dataX;
  List<Category> cat_data;

  QuoteBloc() {
    quotes();
    getCategory();
  }

  quotes() async {
    data = await getAllQuotes();
    _allQuoteController.sink.add(data);
    //
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
  }
}
