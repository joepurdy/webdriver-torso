# webdrivertorso.sh Changelog
All notable changes to this project will be documented in this file.

## 1.0.0 - 2020-07-29
### Changed
- Corrected error where the blue rectangle would overlap the red rectangle. In real Webdriver Torso videos red ALWAYS overlaps blue.

### Added
- Created a Dockerfile to streamline dependency installation

## 0.0.2 - 2015-12-13
### Changed
- Removed python dependancy by replacing random number generation with built in `$RANDOM` property
- Switched to using `mktemp` command to generate file names

### Added
- New argument:
    * -t to set text appearing before Slide numbers

## 0.0.1 - 2015-12-13
### Added
- Initial commit
- webdrivertorso.sh generates test videos