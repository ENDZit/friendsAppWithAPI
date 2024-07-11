// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendsOperations.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GetFriendsStore on _GetFriendsStore, Store {
  late final _$friendsListAtom =
      Atom(name: '_GetFriendsStore.friendsList', context: context);

  @override
  ObservableFuture<List<dynamic>> get friendsList {
    _$friendsListAtom.reportRead();
    return super.friendsList;
  }

  @override
  set friendsList(ObservableFuture<List<dynamic>> value) {
    _$friendsListAtom.reportWrite(value, super.friendsList, () {
      super.friendsList = value;
    });
  }

  late final _$friendsAsyncAction =
      AsyncAction('_GetFriendsStore.friends', context: context);

  @override
  Future<List<dynamic>> friends() {
    return _$friendsAsyncAction.run(() => super.friends());
  }

  late final _$_GetFriendsStoreActionController =
      ActionController(name: '_GetFriendsStore', context: context);

  @override
  Future<List<dynamic>> updateFriends() {
    final _$actionInfo = _$_GetFriendsStoreActionController.startAction(
        name: '_GetFriendsStore.updateFriends');
    try {
      return super.updateFriends();
    } finally {
      _$_GetFriendsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
friendsList: ${friendsList}
    ''';
  }
}
