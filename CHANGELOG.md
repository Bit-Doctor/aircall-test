# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.0.4] - 2016-12-05
### Added
 - A seed file.
 - Routes for hangup action and direct call.
 - A task file to init plivo applications and endpoints.

### Changed
 - This file add wrong url for tags link.  

## [0.0.3] - 2016-12-05
### Added
 - Plivo call authentication.
 - The call model to save call history.
 - Calls controller and a index page listing the call history.
 - A name column to UserNumber and CompanyNumber.
 - Save calls information during call flow.

### Changed
 - Added a step in deployment section in the README.

## [0.0.2] - 2016-12-05
### Added
 - The plivo gem and some configuration for it.
 - CompanyNumber, UserNumber and User models.
 - Add many to many relation between User and CompanyNumber.
 - Add `has_many` UserNumber association to User model.
 - Forwarding CompanyNumber calls to linked UserNumber.

### Changed
 - The env variable for the db host is now `AIRCALL_DATABASE_HOST`.

## 0.0.1 - 2016-12-05
### Added
 - A README explaining what is the project and how to start it.
 - This CHANGELOG file.
 - A Dockerfile, a .dockerignore and a docker-compose.yml to bootstrap the rails app.
 - A .gitignore for rails app.
 - A Rails skeleton.

[Unreleased]: https://github.com/Bit-Doctor/aircall-test/compare/v0.0.4...HEAD
[0.0.4]: https://github.com/Bit-Doctor/aircall-test/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/Bit-Doctor/aircall-test/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/Bit-Doctor/aircall-test/compare/v0.0.1...v0.0.2
