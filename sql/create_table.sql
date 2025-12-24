DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  -- Date/Time Fields
  "Year" INTEGER,
  "Quarter" INTEGER,
  "Month" INTEGER,
  "DayofMonth" INTEGER,
  "DayOfWeek" INTEGER,
  "FlightDate" DATE,
  
  -- Airline Information
  "Reporting_Airline" VARCHAR(50),
  "DOT_ID_Reporting_Airline" INTEGER,
  "IATA_CODE_Reporting_Airline" VARCHAR(5),
  "Tail_Number" VARCHAR(10),
  "Flight_Number_Reporting_Airline" VARCHAR(10),
  
  -- Origin Airport
  "OriginAirportID" INTEGER,
  "OriginAirportSeqID" INTEGER,
  "OriginCityMarketID" INTEGER,
  "Origin" VARCHAR(5),
  "OriginCityName" VARCHAR(100),
  "OriginState" VARCHAR(2),
  "OriginStateFips" INTEGER,
  "OriginStateName" VARCHAR(50),
  "OriginWac" INTEGER,
  
  -- Destination Airport
  "DestAirportID" INTEGER,
  "DestAirportSeqID" INTEGER,
  "DestCityMarketID" INTEGER,
  "Dest" VARCHAR(5),
  "DestCityName" VARCHAR(100),
  "DestState" VARCHAR(2),
  "DestStateFips" INTEGER,
  "DestStateName" VARCHAR(50),
  "DestWac" INTEGER,
  
  -- Departure Information
  "CRSDepTime" INTEGER,
  "DepTime" INTEGER,
  "DepDelay" NUMERIC(10,2),
  "DepDelayMinutes" NUMERIC(10,2),
  "DepDel15" INTEGER,
  "DepartureDelayGroups" INTEGER,
  "DepTimeBlk" VARCHAR(20),
  "TaxiOut" NUMERIC(10,2),
  "WheelsOff" INTEGER,
  
  -- Arrival Information
  "WheelsOn" INTEGER,
  "TaxiIn" NUMERIC(10,2),
  "CRSArrTime" INTEGER,
  "ArrTime" INTEGER,
  "ArrDelay" NUMERIC(10,2),
  "ArrDelayMinutes" NUMERIC(10,2),
  "ArrDel15" INTEGER,
  "ArrivalDelayGroups" INTEGER,
  "ArrTimeBlk" VARCHAR(20),
  
  -- Flight Status
  "Cancelled" INTEGER,
  "CancellationCode" VARCHAR(1),
  "Diverted" INTEGER,
  
  -- Flight Time/Distance
  "CRSElapsedTime" NUMERIC(10,2),
  "ActualElapsedTime" NUMERIC(10,2),
  "AirTime" NUMERIC(10,2),
  "Flights" INTEGER,
  "Distance" NUMERIC(10,2),
  "DistanceGroup" INTEGER,
  
  -- Delay Causes (in minutes)
  "CarrierDelay" NUMERIC(10,2),
  "WeatherDelay" NUMERIC(10,2),
  "NASDelay" NUMERIC(10,2),
  "SecurityDelay" NUMERIC(10,2),
  "LateAircraftDelay" NUMERIC(10,2),
  
  -- Additional Time Info
  "FirstDepTime" INTEGER,
  "TotalAddGTime" NUMERIC(10,2),
  "LongestAddGTime" NUMERIC(10,2),
  
  -- Diversion Information
  "DivAirportLandings" INTEGER,
  "DivReachedDest" INTEGER,
  "DivActualElapsedTime" NUMERIC(10,2),
  "DivArrDelay" NUMERIC(10,2),
  "DivDistance" NUMERIC(10,2),
  
  -- Diversion Details (up to 5 diversions)
  -- Div1
  "Div1Airport" VARCHAR(5),
  "Div1AirportID" INTEGER,
  "Div1AirportSeqID" INTEGER,
  "Div1WheelsOn" INTEGER,
  "Div1TotalGTime" NUMERIC(10,2),
  "Div1LongestGTime" NUMERIC(10,2),
  "Div1WheelsOff" INTEGER,
  "Div1TailNum" VARCHAR(10),
  
  -- Div2-5 (similar structure, keeping as appropriate types)
  "Div2Airport" VARCHAR(5),
  "Div2AirportID" INTEGER,
  "Div2AirportSeqID" INTEGER,
  "Div2WheelsOn" INTEGER,
  "Div2TotalGTime" NUMERIC(10,2),
  "Div2LongestGTime" NUMERIC(10,2),
  "Div2WheelsOff" INTEGER,
  "Div2TailNum" VARCHAR(10),
  
  "Div3Airport" VARCHAR(5),
  "Div3AirportID" INTEGER,
  "Div3AirportSeqID" INTEGER,
  "Div3WheelsOn" INTEGER,
  "Div3TotalGTime" NUMERIC(10,2),
  "Div3LongestGTime" NUMERIC(10,2),
  "Div3WheelsOff" INTEGER,
  "Div3TailNum" VARCHAR(10),
  
  "Div4Airport" VARCHAR(5),
  "Div4AirportID" INTEGER,
  "Div4AirportSeqID" INTEGER,
  "Div4WheelsOn" INTEGER,
  "Div4TotalGTime" NUMERIC(10,2),
  "Div4LongestGTime" NUMERIC(10,2),
  "Div4WheelsOff" INTEGER,
  "Div4TailNum" VARCHAR(10),
  
  "Div5Airport" VARCHAR(5),
  "Div5AirportID" INTEGER,
  "Div5AirportSeqID" INTEGER,
  "Div5WheelsOn" INTEGER,
  "Div5TotalGTime" NUMERIC(10,2),
  "Div5LongestGTime" NUMERIC(10,2),
  "Div5WheelsOff" INTEGER,
  "Div5TailNum" VARCHAR(10)
);
