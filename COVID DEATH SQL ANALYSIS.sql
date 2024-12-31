--IDENTIFYING GLOBAL TRENDS IN COVID-19 DEATH RATES--
SELECT 
    continent,
    ROUND(AVG(new_deaths), 2) AS avg_daily_deaths,
    ROUND(SUM(new_deaths) / SUM(new_cases) * 100, 2) AS mortality_rate_percentage
FROM 
    CovidDeaths
WHERE 
    new_cases > 0 -- Avoid division by zero
GROUP BY 
    continent
ORDER BY 
    avg_daily_deaths DESC;


--COMPARE MORTALITY RATES BY SOCIO-ECONOMIC INDICATORS--
SELECT 
    location,
    gdp_per_capita,
    ROUND(SUM(new_deaths) / SUM(new_cases) * 100, 2) AS mortality_rate_percentage
FROM 
    CovidDeaths
WHERE 
    new_cases > 0 AND gdp_per_capita IS NOT NULL
GROUP BY 
    location, gdp_per_capita
ORDER BY 
    gdp_per_capita DESC;


--IME SERIES ANALYSIS OF MORTALITY RAYES--
SELECT 
    date,
    SUM(new_deaths) AS total_new_deaths
FROM 
    CovidDeaths
GROUP BY 
    date
ORDER BY 
    date;

--TOP 5 COUNTRIES WITH THE HIGHEST MORTALITY RATE--
SELECT top 10
    location AS country,
    SUM(total_deaths) AS total_deaths,
    SUM(total_cases) AS total_cases,
    ROUND(SUM(total_deaths) / SUM(total_cases) * 100, 2) AS mortality_rate_percentage
FROM 
    CovidDeaths
WHERE 
    total_cases > 0
GROUP BY 
    location
ORDER BY 
    mortality_rate_percentage DESC

--GENDER SPECIFIC SMOKING RATES AND COVID-19 IMPACT--
	SELECT top 5
    location AS country,
    ROUND(AVG(female_smokers), 2) AS avg_female_smokers,
    ROUND(AVG(male_smokers), 2) AS avg_male_smokers,
    SUM(new_deaths) AS total_new_deaths
FROM 
    CovidDeaths
WHERE 
    new_deaths > 0 AND (female_smokers IS NOT NULL OR male_smokers IS NOT NULL)
GROUP BY 
    location
ORDER BY 
    total_new_deaths DESC;
