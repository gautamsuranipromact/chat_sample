import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:chat_sample/model/user.dart' as userModel;

part 'database_manager.g.dart';

class User extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get serverId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {serverId};
}

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get message => text()();

  IntColumn get fromUserId => integer().nullable()();

  IntColumn get toUserId => integer().nullable()();

  TextColumn get createdDateTime => text()();

  IntColumn get serverId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {serverId};
}

@DriftDatabase(tables: [User, Messages])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<UserData>> get allTodoEntries => select(user).get();

  Future<void> insertMultipleEntries(List<userModel.User> users) async {
    await batch((batch) {
      // functions in a batch don't have to be awaited - just
      // await the whole batch afterwards.
      List<UserCompanion> userCompanion = [];
      for (int i = 0; i < users.length; i++) {
        userCompanion.add(UserCompanion.insert(
            name: users[i].name!, serverId: Value(users[i].id)));
      }
      batch.insertAll(user, userCompanion);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
