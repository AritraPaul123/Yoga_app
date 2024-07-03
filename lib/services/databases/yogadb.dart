import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/model.dart';

class YogaDataBase {
  static final YogaDataBase instance = YogaDataBase._init();
  static Database? _database;
  YogaDataBase._init();

  Future<Database> _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initializeDB("YogaDB10.db");
    return _database;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE ${YogaModel.TableName1}(
    ${YogaModel.IDName} $idType,
    ${YogaModel.YogaName} $textType,
    ${YogaModel.SecondsOrNot} $boolType,
    ${YogaModel.ImageName} $textType,
    ${YogaModel.SecondsOrTimes} $textType,
    ${YogaModel.Description} $textType
    )
    ''');
    await db.execute('''
    CREATE TABLE ${YogaModel.TableName2}(
    ${YogaModel.IDName} $idType,
    ${YogaModel.YogaName} $textType,
    ${YogaModel.SecondsOrNot} $boolType,
    ${YogaModel.ImageName} $textType,
    ${YogaModel.SecondsOrTimes} $textType,
    ${YogaModel.Description} $textType
    )
    ''');
    // await db.execute('''
    // CREATE TABLE ${YogaModel.TableName3}(
    // ${YogaModel.IDName} $idType,
    // ${YogaModel.YogaName} $textType,
    // ${YogaModel.SecondsOrNot} $boolType,
    // ${YogaModel.ImageName} $textType,
    // ${YogaModel.SecondsOrTimes} $textType,
    // ${YogaModel.Description} $textType
    // )
    // ''');
    await db.execute('''
    CREATE TABLE ${YogaModel.TableSummary}(
    ${YogaModel.IDName} $idType,
    ${YogaModel.YogaPackName} $textType,
    ${YogaModel.WorkoutName} $textType,
    ${YogaModel.BackImgName} $textType,
    ${YogaModel.TotalTime} $textType,
    ${YogaModel.TotalWorkOut} $textType,
    ${YogaModel.KCAL} $textType
    )
    ''');
  }

  Future<Yoga?> insert(Yoga yoga, String tableName) async {            //Inserts individual workouts in database
    final db = await instance.database;
    final id = await db?.insert(tableName, yoga.toJson());
    return yoga.copy(id: id);
  }

  Future<YogaSummary> insertSummary(                                   //Inserts data of whole set of workouts in database
      YogaSummary yogaSum, String tableName) async {
    final db = await instance.database;
    final id = await db?.insert(tableName, yogaSum.toJson());
    return yogaSum.copy(id: id);
  }

  Future<List<Yoga>> readAllYoga(String tableName) async {             //Reads all yoga workouts
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} ASC';
    final queryRes = await db!.query(tableName, orderBy: orderBy);
    return queryRes.map((json) => Yoga.fromJson(json)).toList();
  }

  Future<Yoga?> readOneYoga(int id, String tableName) async {          //read one single workout
    final db = await instance.database;
    final map = await db?.query(tableName,
        columns: YogaModel.Yogatable1Columns,
        where: '${YogaModel.IDName} = ?',
        whereArgs: [id]);
    if (map!.isNotEmpty) {
      return Yoga.fromJson(map.first);
    } else {
      return null;
    }
  }

  // Future<List<Future<YogaSummary?>>> readAllYogaSum(String Tablename) async {
  //   final db=await instance.database;
  //   final orderBy='${YogaModel.IDName} ASC';
  //   final query_res=await db!.query(Tablename, orderBy: orderBy);
  //   return query_res.map((json) => YogaSummary.fromJson(json)).toList();
  // }

  Future<List<YogaSummary>> readAllYogaSum(String tableName) async {        //read summary data of all workout sets
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} DESC';
    final queryResult = await db!.query(tableName, orderBy: orderBy);
    return queryResult.map((json) => YogaSummary.fromJson(json)).toList();
  }
}
