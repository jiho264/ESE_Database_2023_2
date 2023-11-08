Commands
SQLite: New Query   Create a new untitled sqlite file.

SQLite: Run Query   Execute query script in the editor.

SQLite: Quick Query   Choose a database and execute a query without creating a new document.

SQLite: Use Database   Bind current sql document to the selected database.

SQLite: Open Database   Open the selected database in the sqlite explorer.

SQLite: Close Database   Remove the selected database from the sqlite explorer.

SQLite: Refresh Databases   Refresh databases open in the sqlite explorer.

SQLite: Show output   Show the extension's output channel.

SQLite: Change Workspace Trust   Change the trust of this workspace. By default every workspace is untrusted for security reasons.



Settings
"sqlite.sqlite3": string   sqlite3 command or CLI executable path (this setting is disabled for untrusted workspaces)

"sqlite.logLevel": string   Set output channel log level (DEBUG, INFO, WARN, ERROR).

"sqlite.recordsPerPage": number   Number of records to show per page. (-1 to show all records).

"sqlite.databaseExtensions": string[]   The file extensions recognized as SQLite database.

"sqlite.setupDatabase": { [path]: { sql: string[] } }   Custom query to run when opening a database.

In each entry the key is the path of the database and the value is an object with the SQL queries to run (in order).

For example:

{ "./users.db": { "sql": ["PRAGMA foreign_keys = ON;"] } }

Means that every time the database users.db is opened, the SQL query PRAGMA foreign_keys = ON; is executed.