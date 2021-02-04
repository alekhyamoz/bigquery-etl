CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.org_mozilla_ios_klar.events`
AS SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info)
FROM
  `moz-fx-data-shared-prod.org_mozilla_ios_klar_stable.events_v1`
