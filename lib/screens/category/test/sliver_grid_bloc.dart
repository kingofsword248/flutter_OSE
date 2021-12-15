import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/screens/category/test/remote_api.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CharacterSliverGridBloc {
  final int brandid;
  CharacterSliverGridBloc(this.brandid) {
    _onPageRequest.stream
        .flatMap(_fetchCharacterSummaryList)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);

    _onSearchInputChangedSubject.stream
        .flatMap((_) => _resetSearch())
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  static const _pageSize = 20;

  final _subscriptions = CompositeSubscription();

  final _onNewListingStateController =
      BehaviorSubject<CharacterListingState>.seeded(
    CharacterListingState(),
  );

  Stream<CharacterListingState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<int>();

  Sink<int> get onPageRequestSink => _onPageRequest.sink;

  final _onSearchInputChangedSubject = BehaviorSubject<String>.seeded(null);

  Sink<String> get onSearchInputChangedSink =>
      _onSearchInputChangedSubject.sink;

  String get _searchInputValue => _onSearchInputChangedSubject.value;

  Stream<CharacterListingState> _resetSearch() async* {
    yield CharacterListingState();
    yield* _fetchCharacterSummaryList(0);
  }

  Stream<CharacterListingState> _fetchCharacterSummaryList(int pageKey) async* {
    final lastListingState = _onNewListingStateController.value;
    try {
      final newItems =
          await RemoteApi.getCharacterList(pageKey + 1, _pageSize, brandid);
      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : pageKey + 1;
      yield CharacterListingState(
        error: null,
        nextPageKey: nextPageKey,
        itemList: [...lastListingState.itemList ?? [], ...newItems],
      );
    } catch (e) {
      yield CharacterListingState(
        error: e,
        nextPageKey: lastListingState.nextPageKey,
        itemList: lastListingState.itemList,
      );
    }
  }

  void dispose() {
    _onSearchInputChangedSubject.close();
    _onNewListingStateController.close();
    _subscriptions.dispose();
    _onPageRequest.close();
  }
}

class CharacterSliverGridBloc2 {
  String keyword;
  CharacterSliverGridBloc2(this.keyword) {
    _onPageRequest.stream
        .flatMap(_fetchCharacterSummaryList)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);

    _onSearchInputChangedSubject.stream
        .flatMap((_) => _resetSearch())
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  static const _pageSize = 20;

  final _subscriptions = CompositeSubscription();

  final _onNewListingStateController =
      BehaviorSubject<CharacterListingState>.seeded(
    CharacterListingState(),
  );

  Stream<CharacterListingState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<int>();

  Sink<int> get onPageRequestSink => _onPageRequest.sink;

  final _onSearchInputChangedSubject = BehaviorSubject<String>.seeded(null);

  Sink<String> get onSearchInputChangedSink =>
      _onSearchInputChangedSubject.sink;

  String get _searchInputValue => _onSearchInputChangedSubject.value;

  Stream<CharacterListingState> _resetSearch() async* {
    yield CharacterListingState();
    yield* _fetchCharacterSummaryList(0);
  }

  Stream<CharacterListingState> _fetchCharacterSummaryList(int pageKey) async* {
    final lastListingState = _onNewListingStateController.value;
    try {
      final newItems =
          await RemoteApi.getSearch(pageKey + 1, _pageSize, keyword);
      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : pageKey + 1;
      yield CharacterListingState(
        error: null,
        nextPageKey: nextPageKey,
        itemList: [...lastListingState.itemList ?? [], ...newItems],
      );
    } catch (e) {
      yield CharacterListingState(
        error: e,
        nextPageKey: lastListingState.nextPageKey,
        itemList: lastListingState.itemList,
      );
    }
  }

  void dispose() {
    _onSearchInputChangedSubject.close();
    _onNewListingStateController.close();
    _subscriptions.dispose();
    _onPageRequest.close();
  }
}

class CharacterListingState {
  CharacterListingState({
    this.itemList,
    this.error,
    this.nextPageKey = 0,
  });

  final List<Product> itemList;
  final dynamic error;
  final int nextPageKey;
}
