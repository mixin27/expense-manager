const String initDbScript = """
  CREATE TABLE Category(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    iconCodePoint INTEGER
  );
""";
