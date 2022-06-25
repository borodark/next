;

--
-- Rabbit backed table  для подсчет рейтинга по умолчанию: когда не указаны критерии.
--
-- DROP TABLE reviews.review_queue;

CREATE TABLE reviews.review_queue(
  review_id UUID NOT NULL,
  reviewee_id UUID NOT NULL,
  review_date_unixtime UInt64 NOT NULL,
  reviewee_entity String,
  score String,
  flag String,
  text NATIONAL CHARACTER LARGE OBJECT,
  times_reviewed UInt32,
  times_updated UInt8,
  times_flagged UInt32,
  title NATIONAL CHARACTER LARGE OBJECT,
  evoked_emotion String,
  author_id UUID,
  author_rating Float32,
  author_bithday_unix_time Int64,
  author_biological_sex String,
  author_location_lat Float64,
  author_location_lon Float64,
  author_lang String, -- https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
  author_education String,
  author_occupation String,
  author_position String,
  author_profile_public String,
  author_status String,
  author_times_reviewed UInt32,
  author_times_gave_review UInt32,
  author_times_updated_a_review UInt32,
  author_times_flagged_an_entity UInt32,--  flagged any entity
  author_times_reviews_beeing_flagged UInt32,-- "times_reviews_beeing_flagged"
  author_times_flagged UInt32 -- "how many times profile of the author is flagged"
)
  ENGINE = RabbitMQ SETTINGS rabbitmq_host_port = 'rabbit:5672',
  rabbitmq_exchange_name = 'clickhouse',
  rabbitmq_exchange_type = 'topic',
  rabbitmq_routing_key_list = 'reviews',
  rabbitmq_format = 'JSONEachRow';

   
