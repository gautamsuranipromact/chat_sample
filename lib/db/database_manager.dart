import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:chat_sample/model/user.dart' as user_model;
import 'package:chat_sample/model/message.dart' as message_model;

part 'database_manager.g.dart';

class User extends Table {
  TextColumn get name => text()();

  IntColumn get serverId => integer().customConstraint("UNIQUE")();

  @override
  Set<Column> get primaryKey => {serverId};
}

class Messages extends Table {
  TextColumn get message => text()();

  IntColumn get fromUserId => integer().nullable()();

  IntColumn get toUserId => integer().nullable()();

  TextColumn get createdDateTime => text()();

  IntColumn get serverId => integer().customConstraint("UNIQUE")();

  @override
  Set<Column> get primaryKey => {serverId};
}

@DriftDatabase(tables: [User, Messages])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<user_model.User>> getUsers() async {
    List<UserData> temp = await (select(user)).get();
    List<user_model.User> users = [];
    for (int i = 0; i < temp.length; i++) {
      users.add(user_model.User(id: temp[i].serverId, name: temp[i].name));
    }
    return users;
  }

  Future<void> insertMultipleUsers(List<user_model.User> users) async {
    await batch((batch) {
      List<UserCompanion> userCompanion = [];
      for (int i = 0; i < users.length; i++) {
        userCompanion.add(UserCompanion.insert(
            name: users[i].name!, serverId: Value(users[i].id!)));
      }
      batch.insertAllOnConflictUpdate(user, userCompanion);
    });
  }

  Future<List<message_model.Message>> getMessagesByUser(
      int myId, int toUserId) async {
    List<Message> temp = await (select(messages)
          ..where((m) =>
              ((m.fromUserId.equals(myId) & m.toUserId.equals(toUserId)) |
                  (m.fromUserId.equals(toUserId) & m.toUserId.equals(myId))))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.createdDateTime, mode: OrderingMode.desc)
          ]))
        .get();
    List<message_model.Message> messageList = [];
    for (int i = 0; i < temp.length; i++) {
      message_model.Message tempMessage = message_model.Message(
          id: temp[i].serverId,
          fromUserId: temp[i].fromUserId,
          message: temp[i].message,
          toUserId: temp[i].toUserId,
          createdDateTime: temp[i].createdDateTime);
      if (temp[i].fromUserId == myId) {
        tempMessage.isSent = true;
      } else {
        tempMessage.isSent = false;
      }
      messageList.add(tempMessage);
    }
    return messageList;
  }

  Future<void> insertMultipleMessages(
      List<message_model.Message> messageList) async {
    await batch((batch) {
      List<MessagesCompanion> messagesCompanion = [];
      for (int i = 0; i < messageList.length; i++) {
        messagesCompanion.add(MessagesCompanion.insert(
            serverId: Value(messageList[i].id!),
            createdDateTime: messageList[i].createdDateTime!,
            message: messageList[i].message!,
            toUserId: Value(messageList[i].toUserId!),
            fromUserId: Value(messageList[i].fromUserId!)));
      }
      batch.insertAllOnConflictUpdate(messages, messagesCompanion);
    });
  }

  void deleteAllData() {
    delete(user).go();
    delete(messages).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
