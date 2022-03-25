const String initDbScript = """
  CREATE TABLE Category(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    iconCodePoint INTEGER
  );
""";

const String createExpenseDbScript = """
  CREATE TABLE EXPENSE (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      categoryId INTEGER, 
      title TEXT,
      notes TEXT,
      amount REAL
      );
    """;
