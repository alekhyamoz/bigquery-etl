CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_lockbox.bookmarks_sync`
AS -- Generated by bigquery_etl.view.generate_stable_views

SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.mozilla_lockbox_stable.bookmarks_sync_v1`