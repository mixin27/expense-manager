const String initDbScript = """
  CREATE TABLE Category(
    id INTEGER PRIMARY KEY,
    title TEXT,
    description TEXT,
    iconCodePoint INTEGER
  );
""";
