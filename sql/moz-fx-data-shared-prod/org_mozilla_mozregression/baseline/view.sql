CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.org_mozilla_mozregression.baseline`
AS SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info,
    mozfun.norm.glean_baseline_client_info(client_info, metrics) AS client_info)
FROM
  `moz-fx-data-shared-prod.org_mozilla_mozregression_stable.baseline_v1`
