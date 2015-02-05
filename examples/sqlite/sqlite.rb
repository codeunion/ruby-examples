# An example of using the sqlite adapter in Ruby.
#
# sqlite3 is a gem for interacting with sqlite3 databases.
# Website: http://rdoc.info/github/luislavena/sqlite3-ruby
#
# Read the code and run this file to see some example uses.
# Then, explore and experiment on your own!

require "sqlite3" # Require the sqlite adapter for Ruby

if __FILE__ == $PROGRAM_NAME
  puts ""
  puts "Let's have some fun with SQLite."

  puts ""
  puts "The first thing to do is to create a connection to our database."
  puts "In this case, our database is the file 'example-sqlite.db'."
  db = SQLite3::Database.new "example-sqlite.db"

  puts ""
  puts "Then, we need to set up the database schema."
  puts "Let's create a 'countries' table."

  schema = <<-SQL
    CREATE TABLE IF NOT EXISTS countries (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(50) NOT NULL UNIQUE,
      language VARCHAR(50),
      population INTEGER
    );
  SQL

  puts ""
  puts schema
  db.execute(schema)

  puts ""
  puts "And then let's add some sample data using INSERT statements."

  insert_sql = <<-SQL
    INSERT INTO countries (name, language, population)
    VALUES ('England', 'English', 53012456),
           ('Ethiopia', 'Amharic', 87952991),
           ('Ecuador', 'Spanish', 15223680);
  SQL

  puts ""
  puts insert_sql
  db.execute(insert_sql)

  puts ""
  puts "Cool, we just inserted some data!"
  puts "Notice the order of column names in the first set of parenthesis"
  puts "matches the order of the values in the second set of parenthesis."

  puts ""
  puts "Here's MOAR DOCS describing how 'inserts' work in sqlite:"
  puts "-> https://www.sqlite.org/lang_insert.html"

  puts ""
  puts "Now our database has a 'countries' table with some sample data."
  puts "Let's see what's in it using a SELECT statement."

  select_sql = <<-SQL
    SELECT * FROM countries;
  SQL

  puts ""
  puts select_sql
  puts ""
  p db.execute(select_sql)

  puts ""
  puts "HOLY WOW! An array of arrays. It's a bit of a pain to read though."
  puts "So let's change the settings to use hashes instead."
  db.results_as_hash = true

  puts ""
  puts "...and then select all the records from 'countries' again"

  puts ""
  puts select_sql
  puts ""
  p db.execute(select_sql)

  puts ""
  puts "EVEN BETTER! An array of hashes!"
  puts "Now we can see what data is in which column!"

  results = db.execute(select_sql)

  puts ""
  puts "Country names:"
  results.each do |country|
    puts "- " + country["name"]
  end

  puts ""
  puts "Let's see what else we can do. What's the class of this `db` thing?"

  puts ""
  puts db.class

  puts ""
  puts "If we want to figure out what this class does, we check the docs!"
  puts "-> http://rdoc.info/github/luislavena/sqlite3-ruby/SQLite3/Database"

  puts ""
  puts "Phew, that's a bit overwhelming! All those methods!"
  puts "We care most about:"
  puts "- `SQLite3::Database#execute`"
  puts "- `SQLite3::Database#table_info`"
  puts ""
  puts "Let's stick with those!"

  puts ""
  puts "What does table_info('countries') do?"

  puts ""
  p db.table_info("countries")

  puts ""
  puts "It's an array of column definitions!"
  puts "Now we know what the 'countries' table looks like"

  puts ""
  puts "Now let's try changing some of the data with an UPDATE statement."
  puts "England just experienced a zombie apocalypse. Only a handful survived."

  update_sql = <<-SQL
    UPDATE countries
    SET population = 13721
    WHERE name = 'England';
  SQL

  puts ""
  puts update_sql
  db.execute(update_sql)

  puts ""
  puts "Did it actually update the record? Let's see all those records again."

  puts ""
  puts select_sql
  puts ""
  p db.execute(select_sql)

  puts ""
  puts "Cool, we can see the changes made with that update!"

  puts ""
  puts "Finally, let's clean up after ourselves by removing all of the data."

  delete_sql = <<-SQL
    DELETE FROM countries;
  SQL

  puts ""
  puts delete_sql
  db.execute(delete_sql)

  puts ""
  puts "Now it's your turn! What else can you do with SQLite?"
end
