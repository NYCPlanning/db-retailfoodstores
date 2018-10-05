# NYC Food Stores Database
The Retail Food Stores Database includes license numbers, square footages and business names, and locations from the data provided by NYS DAM. 
With that dataset the Retail Food Stores were broken down into five categories using specific criteria:
* **_Gas Station_**: Keywords
* **_Big Box Stores_**: Keywords
* **_Grocery Stores_**: Keywords & 500 sf <= square_footage <= 5000 sf
* **_Supermarket_**: Keywords & square_footage > 5000
* **_Convenience Store_**: Keywords & 100 sf < square_footage <= 5000 sf

The Retail Food Stores Database can be used to understand what areas of NYC lack access to fresh produce and help to expand and update the [Food Retail Expansion to Support Health (FRESH) Program](https://www.nycedc.com/program/food-retail-expansion-support-health-fresh). 

# Documentation for Building and Maintaining Retail Food Stores DB

## Prerequisites
1. Install Node.js
2. Install PostgreSQL
3. Install PostGIS

## Getting Started
1. Clone this repo and run ```npm install``` inside of it.
2. Clone Data Loading Scripts repo and run ```npm install``` inside of it.
3. Create a database in your PostgreSQL instance to use for this project
4. Create an environment variable in your bash profile that provides your DATABASE_URL. This gets used in all the .sh scripts.
   * ```cd ~/.bash_profile```
   * Open .bash_profile in Sublime and add the following code:
   * ```export DATABASE_URL=postgres://{User}:{Password}@{Host}:{Port}/{Database}```
   * Check that it was created successfully with ```printenv```
5. Plug in your database information in dbconfig.sample.js and save as dbconfig.js.
6. Generate an API ID and Key for Geoclient. [Directions here](https://developer.cityofnewyork.us/api/geoclient-api). Plug these values into the [apiCredentials.sample.js](https://github.com/NYCPlanning/db-facilities/blob/master/apiCredentials.sample.js) and save as apiCredentials.js.
7. Run ```sh 01_dataloading.sh```
8. Run ```sh 02_build.sh```
