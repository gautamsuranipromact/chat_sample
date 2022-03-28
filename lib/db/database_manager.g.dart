// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_manager.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UserData extends DataClass implements Insertable<UserData> {
  final int id;
  final String name;
  final int? serverId;
  UserData({required this.id, required this.name, this.serverId});
  factory UserData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      serverId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}server_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int?>(serverId);
    }
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: Value(id),
      name: Value(name),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      serverId: serializer.fromJson<int?>(json['serverId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'serverId': serializer.toJson<int?>(serverId),
    };
  }

  UserData copyWith({int? id, String? name, int? serverId}) => UserData(
        id: id ?? this.id,
        name: name ?? this.name,
        serverId: serverId ?? this.serverId,
      );
  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, serverId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.name == this.name &&
          other.serverId == this.serverId);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> serverId;
  const UserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.serverId = const Value.absent(),
  });
  UserCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.serverId = const Value.absent(),
  }) : name = Value(name);
  static Insertable<UserData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int?>? serverId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (serverId != null) 'server_id': serverId,
    });
  }

  UserCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int?>? serverId}) {
    return UserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      serverId: serverId ?? this.serverId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int?>(serverId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }
}

class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<int?> serverId = GeneratedColumn<int?>(
      'server_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, serverId];
  @override
  String get aliasedName => _alias ?? 'user';
  @override
  String get actualTableName => 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final String message;
  final int? fromUserId;
  final int? toUserId;
  final String createdDateTime;
  final int? serverId;
  Message(
      {required this.id,
      required this.message,
      this.fromUserId,
      this.toUserId,
      required this.createdDateTime,
      this.serverId});
  factory Message.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Message(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      message: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}message'])!,
      fromUserId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from_user_id']),
      toUserId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to_user_id']),
      createdDateTime: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}created_date_time'])!,
      serverId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}server_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || fromUserId != null) {
      map['from_user_id'] = Variable<int?>(fromUserId);
    }
    if (!nullToAbsent || toUserId != null) {
      map['to_user_id'] = Variable<int?>(toUserId);
    }
    map['created_date_time'] = Variable<String>(createdDateTime);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int?>(serverId);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      message: Value(message),
      fromUserId: fromUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(fromUserId),
      toUserId: toUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(toUserId),
      createdDateTime: Value(createdDateTime),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      message: serializer.fromJson<String>(json['message']),
      fromUserId: serializer.fromJson<int?>(json['fromUserId']),
      toUserId: serializer.fromJson<int?>(json['toUserId']),
      createdDateTime: serializer.fromJson<String>(json['createdDateTime']),
      serverId: serializer.fromJson<int?>(json['serverId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'message': serializer.toJson<String>(message),
      'fromUserId': serializer.toJson<int?>(fromUserId),
      'toUserId': serializer.toJson<int?>(toUserId),
      'createdDateTime': serializer.toJson<String>(createdDateTime),
      'serverId': serializer.toJson<int?>(serverId),
    };
  }

  Message copyWith(
          {int? id,
          String? message,
          int? fromUserId,
          int? toUserId,
          String? createdDateTime,
          int? serverId}) =>
      Message(
        id: id ?? this.id,
        message: message ?? this.message,
        fromUserId: fromUserId ?? this.fromUserId,
        toUserId: toUserId ?? this.toUserId,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        serverId: serverId ?? this.serverId,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('fromUserId: $fromUserId, ')
          ..write('toUserId: $toUserId, ')
          ..write('createdDateTime: $createdDateTime, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, message, fromUserId, toUserId, createdDateTime, serverId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.message == this.message &&
          other.fromUserId == this.fromUserId &&
          other.toUserId == this.toUserId &&
          other.createdDateTime == this.createdDateTime &&
          other.serverId == this.serverId);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<String> message;
  final Value<int?> fromUserId;
  final Value<int?> toUserId;
  final Value<String> createdDateTime;
  final Value<int?> serverId;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.fromUserId = const Value.absent(),
    this.toUserId = const Value.absent(),
    this.createdDateTime = const Value.absent(),
    this.serverId = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required String message,
    this.fromUserId = const Value.absent(),
    this.toUserId = const Value.absent(),
    required String createdDateTime,
    this.serverId = const Value.absent(),
  })  : message = Value(message),
        createdDateTime = Value(createdDateTime);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? message,
    Expression<int?>? fromUserId,
    Expression<int?>? toUserId,
    Expression<String>? createdDateTime,
    Expression<int?>? serverId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (message != null) 'message': message,
      if (fromUserId != null) 'from_user_id': fromUserId,
      if (toUserId != null) 'to_user_id': toUserId,
      if (createdDateTime != null) 'created_date_time': createdDateTime,
      if (serverId != null) 'server_id': serverId,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? message,
      Value<int?>? fromUserId,
      Value<int?>? toUserId,
      Value<String>? createdDateTime,
      Value<int?>? serverId}) {
    return MessagesCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      createdDateTime: createdDateTime ?? this.createdDateTime,
      serverId: serverId ?? this.serverId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (fromUserId.present) {
      map['from_user_id'] = Variable<int?>(fromUserId.value);
    }
    if (toUserId.present) {
      map['to_user_id'] = Variable<int?>(toUserId.value);
    }
    if (createdDateTime.present) {
      map['created_date_time'] = Variable<String>(createdDateTime.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int?>(serverId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('fromUserId: $fromUserId, ')
          ..write('toUserId: $toUserId, ')
          ..write('createdDateTime: $createdDateTime, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _messageMeta = const VerificationMeta('message');
  @override
  late final GeneratedColumn<String?> message = GeneratedColumn<String?>(
      'message', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _fromUserIdMeta = const VerificationMeta('fromUserId');
  @override
  late final GeneratedColumn<int?> fromUserId = GeneratedColumn<int?>(
      'from_user_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _toUserIdMeta = const VerificationMeta('toUserId');
  @override
  late final GeneratedColumn<int?> toUserId = GeneratedColumn<int?>(
      'to_user_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _createdDateTimeMeta =
      const VerificationMeta('createdDateTime');
  @override
  late final GeneratedColumn<String?> createdDateTime =
      GeneratedColumn<String?>('created_date_time', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<int?> serverId = GeneratedColumn<int?>(
      'server_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, message, fromUserId, toUserId, createdDateTime, serverId];
  @override
  String get aliasedName => _alias ?? 'messages';
  @override
  String get actualTableName => 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('from_user_id')) {
      context.handle(
          _fromUserIdMeta,
          fromUserId.isAcceptableOrUnknown(
              data['from_user_id']!, _fromUserIdMeta));
    }
    if (data.containsKey('to_user_id')) {
      context.handle(_toUserIdMeta,
          toUserId.isAcceptableOrUnknown(data['to_user_id']!, _toUserIdMeta));
    }
    if (data.containsKey('created_date_time')) {
      context.handle(
          _createdDateTimeMeta,
          createdDateTime.isAcceptableOrUnknown(
              data['created_date_time']!, _createdDateTimeMeta));
    } else if (isInserting) {
      context.missing(_createdDateTimeMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Message.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserTable user = $UserTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [user, messages];
}
