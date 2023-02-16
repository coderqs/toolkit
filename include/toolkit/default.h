#ifndef TOOLKIT__DEFAULT_H
#define TOOLKIT__DEFAULT_H

// General
#define SUCCEEDED 0
#define FAILED   -1

// TIME
#define MINUTE   60
#define HOUR     60*MINUTE
#define DAY      24*HOUR
#define WEEK     7*DAY
#define MONTH    30*DAY
#define YEAR     365*DAY

#define SEC_MS      1000
#define MINUTE_MS   MINUTE*SEC_MS
#define HOUR_MS     HOUR*SEC_MS 
#define DAY_MS      DAY*SEC_MS  
#define WEEK_MS     WEEK*SEC_MS 
#define MONTH_MS    MONTH*SEC_MS
#define YEAR_MS     YEAR*SEC_MS 

// STL
#ifdef _STRING_
const std::string G_EMPTY_STRING;
#endif //_STRING_

#ifdef _SET_
const std::set G_EMPTY_SET;
#endif // _SET_

#endif // TOOLKIT__DEFAULT_H
