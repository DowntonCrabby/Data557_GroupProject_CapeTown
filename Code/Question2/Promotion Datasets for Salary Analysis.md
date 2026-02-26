# Promotion Datasets for Salary Analysis

## Overview

These datasets were constructed from the DATA 557 faculty salary panel dataset (1976–1995). In the original dataset, each row represents one faculty member in one year.

The purpose of these exports is to support analysis of salary behavior at the time of promotion from Associate Professor to Full Professor.

Only faculty who were promoted from Associate to Full during the observation window are included in these datasets.

Files provided:

- `promoted_faculty_summary.csv`
- `promoted_faculty_longitudinal.csv`
- `promotion_event_dataset.csv`

---

## 1. promoted_faculty_summary.csv

### Description

This dataset contains one row per faculty member who was promoted from Associate to Full Professor between 1976 and 1995.

It provides faculty-level characteristics along with the year of promotion.

### Structure

One row per promoted faculty member.

### Original Variables (from source dataset)

- `id`  
  Faculty identification number.

- `sex`  
  `M` = male, `F` = female.

- `deg`  
  Highest degree attained: `PhD`, `Prof` (professional degree), or `Other`.

- `yrdeg`  
  Year highest degree attained (two-digit year).

- `field`  
  Academic field: `Arts`, `Prof`, or `Other`.

- `startyr`  
  Year faculty member was hired (two-digit year).

### Constructed Variables

- `first_associate_year`  
  The first year in which the faculty member held rank `Assoc`.

- `ever_promoted`  
  Indicator:
  - `1` = faculty member was promoted to `Full` after first becoming `Assoc`
  - `0` = not promoted (note: this file includes only promoted faculty, so this will be `1` for all rows)

- `promotion_year`  
  The first year after `first_associate_year` in which the faculty member held rank `Full`.

  Definition:

  `promotion_year = min(year where rank == "Full" and year > first_associate_year)`

---

## 2. promoted_faculty_longitudinal.csv

### Description

This dataset contains all longitudinal faculty-year records for faculty members who were promoted.

It preserves the full annual salary history for those individuals across the entire observed time window.

### Structure

Multiple rows per faculty member (panel format). Each row represents one faculty-year observation.

### Original Variables (from source dataset)

- `case`
- `id`
- `sex`
- `deg`
- `yrdeg`
- `field`
- `startyr`
- `year`
- `rank`
- `admin`
- `salary`

### Constructed Variables Added

- `first_associate_year`  
  First year the faculty member became `Assoc`.

- `promotion_year`  
  First year the faculty member became `Full` after becoming `Assoc`.

These variables support analyses such as:

- Salary trajectories before and after promotion
- Time relative to promotion (by computing `year - promotion_year`)
- Comparisons of rank changes over time for promoted faculty

---

## 3. promotion_event_dataset.csv

### Description

This dataset contains one row per promoted faculty member and is designed specifically to analyze salary changes at the moment of promotion.

It includes salary in the last Associate year and salary in the first Full year.

### Structure

One row per promoted faculty member.

### Original Variables Included

- `id`
- `sex`
- `deg`
- `yrdeg`
- `field`
- `startyr`

### Constructed Variables

- `first_associate_year`  
  First year faculty member became `Assoc`.

- `promotion_year`  
  First year faculty member became `Full` after becoming `Assoc`.

- `associate_year_before_promotion`  
  The last year in which the faculty member held rank `Assoc` before `promotion_year`.

  Definition:

  `associate_year_before_promotion = max(year where rank == "Assoc" and year < promotion_year)`

- `salary_before_promotion`  
  Salary in `associate_year_before_promotion`.

- `salary_at_promotion`  
  Salary in `promotion_year` (the first Full year).

- `salary_change_at_promotion`  
  Computed as:

  `salary_change_at_promotion = salary_at_promotion - salary_before_promotion`

This measures the immediate salary change associated with promotion.

---

## Notes and Assumptions

1. Promotion definition  
   A promotion is defined as the first occurrence of rank `Full` after first attaining rank `Assoc`.

2. Observation window  
   Data span 1976–1995. Promotions after 1995 are not observed.

3. Right censoring  
   Faculty who became Associate late in the period have limited follow-up time before the dataset ends.

4. Salary units  
   `salary` is monthly salary in dollars, as provided in the source dataset.