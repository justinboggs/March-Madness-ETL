## Project Report

## Cash In On March Madness

### Group 7
### Audelia Torres, Justin Boggs, Kirpatrick Dorsey, Scott Whigham

### Overview

For this project, we chose to focus on March Madness data. Betting on the March Madness tournament continues to grow, and the more data you can obtain, the better. We pulled the last five years of March Madness tournament data as well as conference data for the NCAA. Combining these datasets would offer more flexibility in the analysis one could perform to predict tournament results. For example, in the tournament, teams are seeded based on the regular season and conference tournament results. A team performing well in a weak conference could be seeded higher, but not be as strong as a team playing in a strong conference. Knowing what conference each team is in will allow for stronger predictive analysis of the tournament. 

Note the 3 bonus items at the end
######

* **E**xtract: your original data sources and how the data was formatted (CSV, JSON, pgAdmin 4, etc).

* **T**ransform: what data cleaning or transformation was required.

* **L**oad: the final database, tables/collections, and why this was chosen.

### Extract
The Big_Dance_CSV.csv file contains historical data on March Madness tournaments.
https://data.world/michaelaroy/ncaa-tournament-results/

All of the cbb.csv files contain regular season data per team, including conferences.
https://www.kaggle.com/andrewsundberg/college-basketball-dataset

First, using Jupyter notebook, we read of these files in and performed basic analysis on each to get an idea of what data each file contained.

### Transform
The files required significant cleaning to prepare them for joining and analysis. 

### Jupyter Notebook
1. Performed basic analysis of the tables using .info() and .describe()
2. Renamed the columns for clarity and added column for conference names.

### Postgres
1. Lines 7-11: Filtered data, dropping all data before the year 2015.
2. Lines 13-24: Merge two columns into single column (Home_team and Away_team unioned to "Team")
3. Lines 26-34:  For teams ending in St, Big_Dance.csv had these as St, while cbb.csv had these as St. Perform a replace to replace "." with " ".
4. Lines 36-129:cbb.csv included apostrophes in the team names, Big.Dance did not. Replace " ' " with " ".
5. Certain teams required renaming. For example, in the Big_Dance file, Wisconsin Green Bay was listed as only Green Bay. We had to search and rename 11 team names in the Big_Dance files.
6. A small number of team have changed conferences in the past five years which was resulting in duplicated data. We considered these teams outliers and dropped them from the dataset.              

### Load
Lines 130+: Using Postgres, load the final dataset into a virtual table.

# Bonus
Bonus #1: Using Jupyter Notebook, we performed analysis on the final dataset starting at the heading "Read Final Data View"

Bonus #2: Built website with bootstrap and drop down javascript menus to show analysis and final data

Bonus #3: Added github.io to host website <a href="https://bigtoga.github.io/March-Madness-ETL/" target="__blank">https://bigtoga.github.io/March-Madness-ETL/</a>
