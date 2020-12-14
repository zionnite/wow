import 'package:wow/model/Quote.dart';
import 'package:http/http.dart' as http;

final String mainUrl = 'http://wow.joons-me.com/Api';
Future<List<Quote>> getAllQuotes() async {
  final response = await http.get('$mainUrl/get_quote');
  return quoteFromJson(response.body);
}
