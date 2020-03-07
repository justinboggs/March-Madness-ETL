## Project Report

## Cash In On March Madness

### Audelia Torres, Justin Boggs, Kirpatrick Dorsey, Scott Whigham

### Overview

For this project, we chose to focus on March Madness data. Betting on the March Madness tournament continues to grow, and the more data you can obtain, the better. We pulled the last five years of March Madness tournament data as well as conference data for the NCAA. Combining these datasets would offer more flexibility in the analysis one could perform to predict tournament results. For example, in the tournament, teams are seeded based on the regular season and conference tournament results. A team performing well in a weak conference could be seeded higher, but not be as strong as a team playing in a strong conference. Knowing what conference each team is in will allow for stronger predictive analysis of the tournament. 
######

* **E**xtract: your original data sources and how the data was formatted (CSV, JSON, pgAdmin 4, etc).

* **T**ransform: what data cleaning or transformation was required.

* **L**oad: the final database, tables/collections, and why this was chosen.

### Extract
Big_Dance_CSV.csv file contains historical data on March Madness tournaments.
https://data.world/michaelaroy/ncaa-tournament-results/

cbb19.csv contains regular season data, including conferences.
https://www.kaggle.com/andrewsundberg/college-basketball-dataset


### Transform
#### Big_Dance_CSV
Read in Big_Dance_CSV.csv

Filter Big_Dance_CSV on "Year" >= 2015.
Rename the columns:    "Seed":    "Home_Seed"
                       "Score":   "Home_Score"
                       "Team":    "Home_Team" 
                       "Team.1":  "Away_Team" 
                       "Score.1": "Away_Score"
                       "Seed.1":   "Away_Seed" 

Add the conference column.
                       

#### cbb19



### Load
