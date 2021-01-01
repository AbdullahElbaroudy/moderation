abstract class DatabaseModel {
  int get modelID {}
  String get table {}
  Map<String, dynamic> toMap() {}
  Future<int> saveToDB()async{}
  Future<int> deleteFromDB()async{}
  Future<List<Map<String, dynamic>>> getTableFromDB()async{}
  Future<int> updateRowDB()async{}
  Future<List<Map<String, dynamic>>> selectRowDB()async{}
  
}
