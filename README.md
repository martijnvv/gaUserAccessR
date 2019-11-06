# gaUserAccessR
Create a basic Excel output of all Google Analytics account users with R

## Usecases for this script
This script can return a basic list of useraccess data for a Google Analytics view. Whenever you want to periodically clean up or reach out to your Google Analytics users, this is quite helpful. It also allows you to group long lists of users by email extension (ie gmail.com, company.com, etc). 

## Packages used

The packages I have used are:
* googleAnalyticsR
* writexl
* dplyr
* stringi

## Options to configure before running the script

In order for the script to run successfully on your GA view, you need to update some parts of the script.

### Get your GA account ID, profile ID and View ID

Go to your GA UI to get this data or pull it in via the API with R

### Update the list of non-company email extensions

I have added some obvious non-company email extensions to show how you can easily find the obvious non-company email extensions. You can update this list.
