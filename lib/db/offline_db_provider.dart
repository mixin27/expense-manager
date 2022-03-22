import 'dart:math';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'migrations/db_script.dart';

class OfflineDbProvider {
  OfflineDbProvider._();

  //We use the singleton pattern to ensure that
  //we have only one class instance and provide a global point access to it
  static final OfflineDbProvider provider = OfflineDbProvider._();

  static Database? _database;

  Future<Database> get database async => _database ?? await initDb();

  initDb() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _dbName);

    var migratedDbVersion = DbMigrator.migrations.keys.reduce(max);

    _database = await openDatabase(
      path,
      version: migratedDbVersion,
      onOpen: (_) {},
      onCreate: (db, _) async {
        DbMigrator.migrations.keys.toList()
          ..sort()
          ..forEach((element) async {
            var script = DbMigrator.migrations[element];
            await db.execute(script!);
          });
      },
      onUpgrade: (db, _, __) async {
        var currentDbVersion = await _getCurrentDbVersion(db);

        var upgradeScripts = {
          for (var k in DbMigrator.migrations.keys
              .where((element) => element > currentDbVersion))
            k: DbMigrator.migrations[k]
        };

        if (upgradeScripts.isEmpty) return;

        upgradeScripts.keys.toList()
          ..sort()
          ..forEach(
            (element) async {
              var script = upgradeScripts[element];
              await db.execute(script!);
            },
          );

        _upgradeDbVersion(db, migratedDbVersion);
      },
    );

    return _database;
  }

  _upgradeDbVersion(Database db, int version) async {
    await db.rawQuery("pragma user_version = $version;");
  }

  Future<int> _getCurrentDbVersion(Database db) async {
    var res = await db.rawQuery('PRAGMA user_version;', null);
    var version = res[0]["user_version"].toString();
    return int.parse(version);
  }

  dropDb() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await deleteDatabase(path);
  }

  final String _dbName = "ExpenseManager.db";
}
