-- Set the script metadata variables

 

DO $$

 

DECLARE

 

    ScriptName VARCHAR(100) := 'Creation CHOLERA_0000000002 table';

 

    Version INT := 20230807-01;

 

    Description VARCHAR(500) := 'Initial creation of the CHOLERA_0000000002 table';

 

    Developer VARCHAR(100) := 'Mohanie';

 

    Timestamp TIMESTAMP := current_timestamp;

 

    Executed BOOLEAN := true;

 

BEGIN

 

    -- Begin a transaction

 

    BEGIN

 

        -- Check if the script has been executed before

 

        IF NOT EXISTS (SELECT 1 FROM metadata."ControlTable" WHERE "ScriptName" = ScriptName AND "Version"= Version ) THEN

 

            -- Your SQL script logic here

 

            -- Example: Creating a table

 

            CREATE TABLE IF NOT EXISTS raw."WHO_CHOLERA_0000000002"
            (
                id numeric NOT NULL,
				IndicatorCode character(500),
				SpatialDimType character(500),
				SpatialDim character(500),
				TimeDimType character(500),
				TimeDim integer,
				NumericValue integer
            );

 


            -- Update the control table to indicate that the script has been executed

 

            INSERT INTO metadata."ControlTable" ("ScriptName", "Version", "Description", "Developer", "Timestamp", "Executed")

 

            VALUES (ScriptName, Version, Description, Developer, Timestamp, Executed);

 

        END IF;

 


        -- Commit the transaction

 

--        COMMIT;

 

    EXCEPTION

 

        -- Handle any errors that occur

 

        WHEN OTHERS THEN

 

            -- Rollback the transaction

 

            ROLLBACK;

 

   -- Insert error details into the LoadError table
            INSERT INTO metdata."LoadError" ("ScriptName", "Version", "Description", "Developer", "ErrorMessage", "ErrorTimestamp")
            VALUES (ScriptName, Version, Description, Developer, SQLERRM, current_timestamp);

 

 

            -- Rethrow the error

 

            RAISE;

 

    END;
commit;
END$$;
