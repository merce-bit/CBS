-- Set the script metadata variables

 

DO $$

 

DECLARE

 

    ScriptName VARCHAR(100) := 'Creation IMF_endpoints table';

 

    Version INT := 20230622-01;

 

    Description VARCHAR(500) := 'Initial creation of the IMF_endpoints table';

 

    Developer VARCHAR(100) := 'Merce';

 

    Timestamp TIMESTAMP := current_timestamp;

 

    Executed BOOLEAN := true;

 

BEGIN

 

    -- Begin a transaction

 

    BEGIN

 

        -- Check if the script has been executed before

 

        IF NOT EXISTS (SELECT 1 FROM metdata."ControlTable" WHERE "ScriptName" = ScriptName AND "Version"= Version ) THEN

 

            -- Your SQL script logic here

 

            -- Example: Creating a table

 

            CREATE TABLE IF NOT EXISTS metdata."IMF_endpoints"
            (
                id numeric NOT NULL,
                sourceRelativeURL character(200),
                source_data character(200),
                timestamp timestamp without time zone,
                sourceBaseURL character(500),
                sinkTableName character(500),
                CONSTRAINT "IMF_endpoints_pkey" PRIMARY KEY (id)
            );

 


            -- Update the control table to indicate that the script has been executed

 

            INSERT INTO metdata."ControlTable" ("ScriptName", "Version", "Description", "Developer", "Timestamp", "Executed")

 

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