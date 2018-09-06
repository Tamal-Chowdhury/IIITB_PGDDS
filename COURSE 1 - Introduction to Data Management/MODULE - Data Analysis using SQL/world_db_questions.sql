use world;
show tables;
describe city;
describe country;
describe countrylanguage;

# 1. count of cities
select count(ID)
from world.city; -- including duplicate

select count(distinct(Name))
from world.city; -- distinct cities
    
# 2. Country having highest number of cities
select co.Name, count(distinct(c.Name)) as coun 
from world.city c, world.country co 
where c.CountryCode = co.Code
group by c.CountryCode
order by coun desc
limit 1;

# 3. Which language is its country’s official language and spoken by 80 to 90 percent of people
Select language, Percentage
from countrylanguage
where IsOfficial = 'T' and Percentage >= 80 and Percentage <= 90;

# 4. In India, how many cities have been listed in “Maharashtra” district?
select count(distinct ct.Name) 
from city as ct join country as cnt on ct.countrycode = cnt.code 
where ct.District = 'Maharashtra' and cnt.Name = 'India';

select count(distinct Name)
from city
where District = 'Maharashtra' and CountryCode = 'IND';  -- to verify the result

# 5. Which country has the maximum population (if population is taken as the population from the country table)
select Name 
from country
order by Population desc
limit 1;

# 6. Which language is spoken in the maximum number of countries?
Select language
from countrylanguage
group by Language
order by count(distinct(CountryCode)) desc
limit 1;

# 7. Among the following, which language is the official language of the more number of countries?
Select language
from countrylanguage
where IsOfficial = 'T'
group by Language
order by count(distinct(CountryCode)) desc
limit 1;

# 8. How many cities in North America are there where English is the official language
select count(distinct ci.ID)
from countrylanguage cl join country c on cl.CountryCode = c.Code join city ci on c.code = ci.CountryCode 
where c.Continent = 'North America' and cl.Language = 'English'and cl.IsOfficial = 'T';

# 9. Which city has the maximum population among these
Select Name
from city
order by Population desc
limit 1;

# 10. How many row entries are there with any value in the country table being NA
select count(*)
from country
where Region = 'NA' or Name = 'NA' or Region = 'NA' or LocalName = 'NA' or GovernmentForm = 'NA' or HeadOfState = 'NA' or Code2 = 'NA'
or Continent = 'NA' or SurfaceArea = 'NA' or IndepYear = 'NA' or Population = 'NA' or LifeExpectancy = 'NA'
or GNP = 'NA' or GNPOld = 'NA' or Capital = 'NA';  -- Note : for numibia country code is NA . for all char field only 1 is result.
-- But in case of numeric NA == null .

select count(*)
from country
where Region is null or Name is null or Region is null or LocalName is null or GovernmentForm is null or HeadOfState is null or Code2 is null
or Continent is null or SurfaceArea is null or IndepYear is null or Population is null or LifeExpectancy is null
or GNP is null or GNPOld is null or Capital is null;  -- solution required.

# 11. How many countries are there whose name starts with I and ends with A
select count(distinct Name)
from country
where lower(Name) like 'i%a';

# 12. Which continent has least surface area
select Continent
from country
group by Continent
order by sum(SurfaceArea) 
limit 1;