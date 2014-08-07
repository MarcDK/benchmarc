FILE: benchmarc.sh

USAGE: benchmarc.sh urls.txt 10 (optional)

DESCRIPTION: Measures the average sever response time of urls in milliseconds.
First parameter specifies a plain text file with urls. Second parameter sets
the number of runs for each url. The script uses no-cache headers and timestamps
at the end of each url to invalidate caches like varnish.

OPTIONS: see function ’usage’ below
BUGS: ---
NOTES: ---
AUTHOR: Marc Tönsing
COMPANY: EatSmarter.de
VERSION: 1.0
CREATED: 06.08.2014
REVISION: 07.08.2014
