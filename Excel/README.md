# Project: Accommodation Management System for the Marche Region

**Description**

This project involves developing a system for managing accommodation facilities in the Marche region, using two data files: one with the list of accommodations and another with average prices per city. The main tasks are:

**Tasks**

File "elencostrutture.xlsx":

- Complete the missing information in the "RICERCA" sheet.
- Add a dropdown menu in cell C3 (yellow cell) to select the accommodation name.
- Populate the total number of accommodations in the region and the number of accommodations in the city of the selected structure in the grey cells.
- Create a pivot table in the "PIVOT" sheet to show the number of accommodations by category, filterable by city.

File "modello_dati.xlsx":

- Load the data from the "STRUTTURE RICETTIVE" sheet of elencostrutture.xlsx into Power Query to apply necessary transformations (data cleaning, formatting, etc.).
- Insert the table into the data model using Power Pivot.
- Load the data from the prezzimedi.csv file into Power Query, transform it, and insert it into the data model using Power Pivot.
- Create a relationship between the two tables.
