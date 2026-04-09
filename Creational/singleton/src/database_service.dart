class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  String connectionString = "postgres://localhost:5432/my_db";

  DatabaseService._internal() {
    print("Instancia de DatabaseService inicializada.");
  }
  
  factory DatabaseService() {
    return _instance;
  }

  void connect() {
    print("Conectado a: $connectionString");
  }
}