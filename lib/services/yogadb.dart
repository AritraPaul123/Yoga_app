import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class YogaDataBase{
  static final YogaDataBase instance=YogaDataBase._init();
  static Database? _database;
  YogaDataBase._init();

  Future<Database> _initializeDB(String filepath) async {
    final dbpath=await getDatabasesPath();
    final path=join(dbpath,filepath);
    return await openDatabase(path, version: 1,onCreate: _createDB);
  }

  Future<Database?> get database async{
    if(_database!=null){
      return _database;
    }
    _database=await _initializeDB("YogaDB8.db");
    return _database;
  }

  Future _createDB(Database db, int version) async {
    final idType='INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType='TEXT NOT NULL';
    final boolType='BOOLEAN NOT NULL';

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

  Future<Yoga?> Insert(Yoga yoga, String Tablename) async {
    final db=await instance.database;
    final id=await db?.insert(Tablename, yoga.toJson());
    return yoga.copy(id:id);
  }
  Future<YogaSummary> InsertSummary(YogaSummary yogasum,String Tablename) async {
    final db=await instance.database;
    final id=await db?.insert(Tablename, yogasum.toJson());
    return yogasum.copy(id:id);
  }
  Future<List<Yoga>> readAllYoga(String Tablename) async {
    final db=await instance.database;
    final orderBy='${YogaModel.IDName} ASC';
    final query_res=await db!.query(Tablename, orderBy: orderBy);
    return query_res.map((json)=>Yoga.fromJson(json)).toList();
  }
  
  Future<Yoga?> readOneYoga(int id,String Tablename) async {
    final db=await instance.database;
    final map=await db?.query(Tablename, columns: YogaModel.Yogatable1Columns, where: '${YogaModel.IDName} = ?' ,whereArgs: [id]);
    if(map!.isNotEmpty){
      return Yoga.fromJson(map!.first);
    }else{
      return null;
    }
  }

  // Future<List<Future<YogaSummary?>>> readAllYogaSum(String Tablename) async {
  //   final db=await instance.database;
  //   final orderBy='${YogaModel.IDName} ASC';
  //   final query_res=await db!.query(Tablename, orderBy: orderBy);
  //   return query_res.map((json) => YogaSummary.fromJson(json)).toList();
  // }

  Future<List<YogaSummary>> readAllYogaSum(String Tablename) async{
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} DESC';
    final query_result = await db!.query(Tablename,orderBy: orderBy);
    return query_result.map((json) => YogaSummary.fromJson(json)).toList();
  }
}