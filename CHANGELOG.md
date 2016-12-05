# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
 - The plivo gem and some configuration for it.
 - CompanyNumber, UserNumber and User models.
 - Add many to many relation between User and CompanyNumber.

### Changed
 - The env variable for the db host is now `AIRCALL_DATABASE_HOST`.

## 0.0.1 - 2016-12-05
### Added
 - A README explaining what is the project and how to start it.
 - This CHANGELOG file.
 - A Dockerfile, a .dockerignore and a docker-compose.yml to bootstrap the rails app.
 - A .gitignore for rails app.
 - A Rails skeleton.

[Unreleased]: https://github.com/olivierlacan/keep-a-changelog/compare/v0.0.1...HEAD
