# frozen_string_literal: true

require 'sqlite3'

# Handles seeding/generation of db
class Seeder
  # Seeds the database
  def self.seed!
    db = connect
    drop_tables(db)
    puts 'Deleted old tables'
    create_tables(db)
    puts 'Created new tables'
  end

  # Connects to the db
  def self.connect
    SQLite3::Database.new 'db/data.db'
  end

  # Drops tables if they excist
  #
  # db - (database Object)
  def self.drop_tables(db)
    db.execute('DROP TABLE IF EXISTS posts;')
    db.execute('DROP TABLE IF EXISTS users;')
    db.execute('DROP TABLE IF EXISTS blogs;')
  end

  # Creates tables in the db
  #
  # db - (database Object)
  # rubocop:disable Metrics/MethodLength
  def self.create_tables(db)
    db.execute 'CREATE TABLE "posts" (
            "id" INTEGER PRIMARY KEY,
            "header"	TEXT NOT NULL,
            "body"	TEXT,
            "postStatus"	TEXT NOT NULL,
            "authorId" INTEGER NOT NULL,
            "blogId" INTEGER NOT NULL,
            "postParent" INTEGER,
            "time" TEXT,
            "postName" TEXT UNIQE NOT NULL
        );'
    db.execute 'CREATE TABLE "users" (
            "id" INTEGER PRIMARY KEY,
            "username"	TEXT NOT NULL,
            "email"	TEXT NOT NULL,
            "password" TEXT NOT NULL,
            "registerTime" TEXT NOT NULL,
            "status" INTEGER
        );'
    db.execute 'CREATE TABLE "blogs" (
            "id" INTEGER PRIMARY KEY,
            "name"	TEXT NOT NULL
        );'
  end
  # rubocop:enable Metrics/MethodLength
end
