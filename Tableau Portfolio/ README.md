# Tableau Project SQL Queries

This repository contains a bunch of SQL queries I used for a Tableau project on COVID-19 data. The queries help pull out data to get some key insights into the number of COVID-19 cases, deaths, vaccinations, and population stats from the PortfolioProject database.

## Queries Overview

### 1. Total COVID-19 Cases and Death Percentage

- Query: `total_cases_and_death_percentage.sql`
- Description: Calculates the total number of COVID-19 cases, total deaths, and the death percentage worldwide.
- Filter: Includes data for continents with valid records.
- Order: Results are ordered by total cases and total deaths.

### 2. Total Deaths by Location (Excluding World, European Union, International)

- Query: `total_deaths_by_location.sql`
- Description: Lists the total death count for each location (excluding World, European Union, and International).
- Filter: Excludes specific locations for consistency.
- Order: Results are ordered by the total death count in descending order.

### 3. Highest Infection Count by Location

- Query: `highest_infection_count_by_location.sql`
- Description: Identifies locations with the highest infection counts, including the highest count and percentage of population infected.
- Order: Results are ordered by the percentage of population infected in descending order.

### 4. Highest Infection Count by Location and Date

- Query: `highest_infection_count_by_location_and_date.sql`
- Description: Lists the highest infection count for each location on different dates, including the percentage of population infected.
- Order: Results are ordered by the percentage of population infected in descending order.


