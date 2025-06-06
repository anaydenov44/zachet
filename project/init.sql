-- Удаление старых таблиц (если существуют)
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS apps;

-- Создание таблицы apps (с учётом всех колонок из CSV)
CREATE TABLE apps (
  App VARCHAR(255),
  Category VARCHAR(255),
  Rating NUMERIC,
  Reviews INT,
  Size VARCHAR(50),
  Installs VARCHAR(50),
  Type VARCHAR(50),
  Price VARCHAR(50),
  Content_Rating VARCHAR(50),
  Genres VARCHAR(255),
  Last_Updated DATE,
  Current_Version VARCHAR(50),
  Android_Version VARCHAR(50)
);

-- Создание таблицы reviews
CREATE TABLE reviews (
  App VARCHAR(255),
  Translated_Review TEXT,
  Sentiment VARCHAR(50),
  Sentiment_Polarity NUMERIC
);

-- Загрузка данных из CSV с обработкой ошибок
COPY apps (
  App,
  Category,
  Rating,
  Reviews,
  Size,
  Installs,
  Type,
  Price,
  Content_Rating,
  Genres,
  Last_Updated,
  Current_Version,
  Android_Version
)
FROM '/csv/googleplaystore.csv'
DELIMITER ',' CSV HEADER LOG ERRORS FORCE_NULL(Rating, Reviews);

COPY reviews (
  App,
  Translated_Review,
  Sentiment,
  Sentiment_Polarity
)
FROM '/csv/googleplaystore_user_reviews.csv'
DELIMITER ',' CSV HEADER LOG ERRORS FORCE_NULL(Sentiment_Polarity);

-- Очистка таблиц перед вставкой тестовых данных (опционально)
TRUNCATE TABLE apps, reviews;

-- Вставка тестовых данных в таблицу apps
INSERT INTO apps (
  App, Category, Rating, Reviews, Size, Installs, Type, Price, Content_Rating, Genres, Last_Updated, Current_Version, Android_Version
) VALUES
('WhatsApp', 'Communication', 4.5, 10000, '10M', '1B+', 'Free', '0', 'Everyone', 'Social', '2023-01-01', '2.21.15.28', '4.0.3 and up'),
('Instagram', 'Social', 4.3, 80000, '20M', '100M+', 'Free', '0', 'Teen', 'Photo & Video', '2
