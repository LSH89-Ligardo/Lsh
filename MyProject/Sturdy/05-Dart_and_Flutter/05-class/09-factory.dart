class DatabaseConnection {
  static DatabaseConnection? _instance; // private static instance
  final String _connectionString;

  DatabaseConnection._internal(this._connectionString) {
    print('Connection string: $_connectionString');
  }

  factory DatabaseConnection(String connectionString) {
    // instance 가 null 일 때만 생성
    _instance ??= DatabaseConnection._internal(connectionString);
    // !: null safety를 무시하고 사용
    return _instance!;
  }

  void connect() {
    print('Connected to database with connection string: $_connectionString');
  }

  void disconnect() {
    print('Disconnected from database');
  }

  void query(String query) {
    print('Executing query: $query');
  }
}

void main() {
  var connection1 = DatabaseConnection('my-database');
  connection1.connect();
  connection1.query('SELECT * FROM table1');
  connection1.disconnect();

  // connection2는 connection1과 동일한 인스턴스를 참조
  var connection2 = DatabaseConnection('my-database2');
  connection2.connect();
  connection2.query('SELECT * FROM table2');
  connection2.disconnect();

  // connection3는 새로운 인스턴스를 생성하지 않고 connection1과 동일한 인스턴스를 참조
  var connection3 = DatabaseConnection('your-database3');
  connection3.connect();
  connection3.query('SELECT * FROM table3');
  connection3.disconnect();
}
