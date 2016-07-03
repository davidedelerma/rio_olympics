DROP TABLE medals;
DROP TABLE events;
DROP TABLE athletes;
DROP TABLE nations;

CREATE TABLE nations(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) not null
);

CREATE TABLE athletes(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) not null,
  last_name VARCHAR(255) not null,
  nation_id INT4 references nations(id) ON DELETE CASCADE
);

CREATE TABLE events(
  id SERIAL4 PRIMARY KEY,
  event_date DATE,
  discipline VARCHAR(255) not null
);

CREATE TABLE medals(
  id SERIAL4 PRIMARY KEY,
  event_id INT4 references events(id) ON DELETE CASCADE,
  athlete_id INT4 references athletes(id) ON DELETE CASCADE,
  medals_type VARCHAR(255) not null
);