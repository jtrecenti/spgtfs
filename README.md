[![Travis-CI Build Status](https://travis-ci.org/jtrecenti/spgtfs.svg?branch=master)](https://travis-ci.org/jtrecenti/spgtfs)

# spgtfs

Downloads GTFS data from SPTrans.

## Install

`spgtfs` is not on CRAN yet. To install, you'll need `devtools`.

```r
if (!require(devtools)) install.packages('devtools')
devtools::install_github('jtrecenti/spgtfs')
```

## Usage

To download GTFS data, you'll need to get a login and a password [here](http://www.sptrans.com.br/desenvolvedores/Default.aspx?login).

```r
library(spgtfs)
gtfs_data <- spgtfs_download('<login>', '<pwd>') %>% 
  spgtfs_load()

gtfs_data
```

```
Downloading: 12 MB
```

```
# A tibble: 10 × 2
                   arq                   data
                 <chr>                 <list>
1           agency.txt       <tibble [1 × 5]>
2         calendar.txt      <tibble [6 × 10]>
3  fare_attributes.txt       <tibble [6 × 6]>
4       fare_rules.txt   <tibble [5,508 × 5]>
5      frequencies.txt  <tibble [40,118 × 4]>
6           routes.txt   <tibble [1,380 × 7]>
7           shapes.txt <tibble [811,592 × 5]>
8            stops.txt  <tibble [19,771 × 5]>
9       stop_times.txt  <tibble [97,174 × 5]>
10           trips.txt   <tibble [2,314 × 6]>
```

