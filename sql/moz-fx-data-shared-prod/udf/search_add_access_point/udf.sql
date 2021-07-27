CREATE OR REPLACE FUNCTION udf.search_add_access_point(entries ARRAY<STRUCT<key STRING, value INT64>>, access_point STRING) AS (
  ARRAY(
    SELECT AS STRUCT
      SUBSTR(key, 1, STRPOS(key, ':') - 1) AS engine,
      CONCAT(SUBSTR(key, STRPOS(key, ':') + 1), '.', access_point) AS source,
      value,
    FROM
      UNNEST(entries)
  )
);

-- Tests
SELECT
  assert.array_equals(
    ARRAY<STRUCT<engine STRING, source STRING, value INT64>>[
        ('engine1', 'organic:none.urlbar', 1),
        ('engine2', 'tagged:code.urlbar', 2),
        ('engine1', 'tagged:code.urlbar', 3)
    ],
    udf.search_add_access_point(
      [
        STRUCT('engine1:organic:none' AS key, 1 AS value),
        STRUCT('engine2:tagged:code' AS key, 2 AS value),
        STRUCT('engine1:tagged:code' AS key, 3 AS value)
      ],
      'urlbar'
    )
  )
