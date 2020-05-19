import 'package:fluttergithub/db/db_provider.dart';
import 'package:fluttergithub/models/index.dart';
import 'package:sqflite/sqflite.dart';

class RepoHistoryDao extends BaseDBProvider {
  ///表名
  final String name = "ReposHistory";

  ///表主键字段
  final String columnId = "_id";

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
  name text,
  full_name text,
  description text,
  language text,
  forks_count integer,
  stargazers_count integer,
  open_issues_count integer,
  login text,
  avatar_url text,
  look_time text)
    ''';
  }

  ///
  /// 插入数据
  ///
  Future insert(RepoDaoBean repoData) async {
    Database db = await getDB();
    bool repoIsExist = await getRepoIsExistByFullName(repoData.full_name);
    //如果repo已经存在，先删除
    if (repoIsExist) {
      await db.delete(name,
          where: "full_name = ?", whereArgs: [repoData.full_name]);
    }
    return await db.insert(name, repoData.toJson());
  }

  ///
  /// 获取当前浏览的Repo是否存在
  ///
  Future<bool> getRepoIsExistByFullName(String fullName) async {
    Database db = await getDB();
    List<Map<String, dynamic>> maps =
        await db.query(name, where: "full_name = ?", whereArgs: [fullName]);
    if (maps.length > 0) {
      return true;
    }
    return false;
  }

  ///
  /// 获取所有的repo历史数据
  ///
  Future<List<RepoDaoBean>> getRepoHistoryList() async {
    Database db = await getDB();
    List<Map<String, dynamic>> maps =
        await db.query(name, orderBy: "look_time DESC");
    if (maps.length > 0) {
      return maps.map((item) => RepoDaoBean.fromJson(item)).toList();
    }
    return null;
  }
}
