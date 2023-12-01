import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:top_git/model/repo_database_model.dart';
import 'package:top_git/model/topratedmodel.dart';

class DataBaseHandler {
  DataBaseHandler.init();
  static final DataBaseHandler instance = DataBaseHandler.init();
  Database? database;

  Future<Database> get initdatabase async {
    if (database != null) {
      log('null');
      return database!;
    } else {
      database = await initializeDatabase();
      log(database.toString());
      return database!;
    }
  }

  Future<Database> initializeDatabase() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'top_git_repos.db');
    log("init");
    try {
      log('trrrr');
      final dbs = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          log('exc');
          try {
            log('ty');
            await db.execute('''
CREATE TABLE top_repo_table(
  id INTEGER PRIMARY KEY,
  name TEXT,
  full_name TEXT,
  description TEXT,
  star_count INTEGER,
  user TEXT,
  avatar_url TEXT
)
''');
            log('success');
          } catch (e) {
            log("fail $e");
          }
        },
      );
      return dbs;
    } catch (e) {
      log("errr $e");
      return database!;
    }
  }

  Future<void> insertData({required DatabaseModel data}) async {
    List<Map<String, dynamic>> existing = await database!
        .query('top_repo_table', where: 'id=?', whereArgs: [data.id]);
    if (existing.isEmpty) {
      final result = await database!.insert('top_repo_table', data.tomap());
      log("re $result");
    } else {
      log('contains');
    }
  }

  Future<void> delete() async {
    await database!.delete('top_repo_table');
  }

  Future<DatabaseModelList> getAllData() async {
    final List<Map<String, dynamic>> maps = await database!.query(
      'top_repo_table',
    );

    return DatabaseModelList.fromList(maps);
  }
}
