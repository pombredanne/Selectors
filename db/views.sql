CREATE VIEW "ReleasesView" AS
SELECT
  Releases.id as id,
  Releases.version as version,
  Architectures.name as architecture,
  Distributions.name as distribution
FROM
  Releases,
  Architectures,
  Distributions
WHERE
  Releases.architecture_id = Architectures.id and
  Releases.distribution_id = Distributions.id;

CREATE VIEW "SelectorsCategoryView" AS
SELECT
  Selectors.id as id,
  Selectors.name as name,
  Selectors.version as version,
  Categories.name as category
FROM
  Selectors,
  Categories
WHERE
  Selectors.category_id = Categories.id;

CREATE VIEW "ProjectSelectorsView" AS
SELECT
  Projects.name as name,
  Projects.id as project_id,
  Selectors.id as selector_id
FROM
  Selectors
JOIN
  Projects
USING
  (name);

CREATE VIEW "ProjectStatisticsView" AS
SELECT
  ProjectSelectorsView.project_id as id,
  ProjectSelectorsView.name as name,
  SelectorStatistics.installations as installations
FROM
  ProjectSelectorsView
JOIN
  SelectorStatistics
USING
  (selector_id);

CREATE VIEW "ReleaseSelectorsView" AS
SELECT
  Selectors.*,
  ReleasesView.version as release_version,
  ReleasesView.architecture as architecture,
  ReleasesView.distribution as distribution
FROM
  Selectors
JOIN
  ReleasesView,
  Releases_have_Selectors
WHERE
  Releases_have_Selectors.selector_id = Selectors.id and
  Releases_have_Selectors.release_id = ReleasesView.id;

CREATE VIEW "SelectorTagsView" AS
SELECT
  Tags.*,
  Selectors.id as selector_id
FROM
  Tags
JOIN
  Selectors,
  Selectors_have_Tags
WHERE
  Selectors_have_Tags.tag_id = Tags.id and
  Selectors_have_Tags.selector_id = Selectors.id;

CREATE VIEW "ProjectTagsView" AS
SELECT
  Tags.*,
  Projects.id as project_id
FROM
  Tags
JOIN
  Projects,
  Projects_have_Tags
WHERE
  Projects_have_Tags.tag_id = Tags.id and
  Projects_have_Tags.project_id = Projects.id;

