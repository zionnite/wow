import 'package:rxdart/subjects.dart';
import 'package:wow/model/model_response/forum_response.dart';
import 'package:wow/repository/quote_repository.dart';

class ForumListBloc{
  final QuoteRepository _quoteRepository  = QuoteRepository();
  final BehaviorSubject<ForumResponse> _subject = BehaviorSubject<ForumResponse>();

  getForum() async{
    ForumResponse response = await  _quoteRepository.getForumPost();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<ForumResponse> get subject => _subject;
}
final forumBloc = ForumListBloc();