CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.org_mozilla_reference_browser.baseline`
AS -- Generated by bigquery_etl.view.generate_stable_views

SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.org_mozilla_reference_browser_stable.baseline_v1`