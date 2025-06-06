from pyspark.sql import SparkSession

# Инициализация Spark-сессии
spark = SparkSession.builder \
    .appName("CSV to Tuples") \
    .getOrCreate()

# Пути к CSV-файлам внутри контейнера
apps_csv_path = "/csv/googleplaystore.csv"
reviews_csv_path = "/csv/googleplaystore_user_reviews.csv"

# Чтение CSV-файлов в DataFrame
apps_df = spark.read \
    .option("header", "true") \
    .option("inferSchema", "false") \
    .option("escape", "\"") \
    .csv(apps_csv_path)

reviews_df = spark.read \
    .option("header", "true") \
    .option("inferSchema", "false") \
    .option("escape", "\"") \
    .csv(reviews_csv_path)

# Преобразование DataFrame в список кортежей
apps_rdd = apps_df.rdd.map(tuple)
reviews_rdd = reviews_df.rdd.map(tuple)

# Вывод первых 5 кортежей из таблицы apps
print("Первые 5 записей из таблицы apps:")
for row in apps_rdd.take(5):
    print(row)

print("\nПервые 5 записей из таблицы reviews:")
# Вывод первых 5 кортежей из таблицы reviews
for row in reviews_rdd.take(5):
    print(row)

# Остановка Spark-сессии
spark.stop()
