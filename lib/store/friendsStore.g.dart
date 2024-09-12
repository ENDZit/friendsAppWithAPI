// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendsStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendsStore on _FriendsStore, Store {
  late final _$friendsListAtom =
      Atom(name: '_FriendsStore.friendsList', context: context);

  @override
  ObservableList<Friend> get friendsList {
    _$friendsListAtom.reportRead();
    return super.friendsList;
  }

  @override
  set friendsList(ObservableList<Friend> value) {
    _$friendsListAtom.reportWrite(value, super.friendsList, () {
      super.friendsList = value;
    });
  }

  late final _$updateFriendsAsyncAction =
      AsyncAction('_FriendsStore.updateFriends', context: context);

  @override
  Future<List<dynamic>> updateFriends() {
    return _$updateFriendsAsyncAction.run(() => super.updateFriends());
  }

  late final _$loadFriendsAsyncAction =
      AsyncAction('_FriendsStore.loadFriends', context: context);

  @override
  Future<void> loadFriends() {
    return _$loadFriendsAsyncAction.run(() => super.loadFriends());
  }

  late final _$addFriendAsyncAction =
      AsyncAction('_FriendsStore.addFriend', context: context);

  @override
  Future<void> addFriend(String name, String age) {
    return _$addFriendAsyncAction.run(() => super.addFriend(name, age));
  }

  late final _$removeFriendAsyncAction =
      AsyncAction('_FriendsStore.removeFriend', context: context);

  @override
  Future<void> removeFriend(String name) {
    return _$removeFriendAsyncAction.run(() => super.removeFriend(name));
  }

  @override
  String toString() {
    return '''
friendsList: ${friendsList}
    ''';
  }
}
