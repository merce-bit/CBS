-- Set the script metadata variables

 

DO $$

 

DECLARE

 

    ScriptName VARCHAR(100) := 'LoadError table creation';

 

    Version INT := 20230622-01;

 

    Description VARCHAR(500) := 'Initial creation of the LoadError table';

 

    Developer VARCHAR(100) := 'Merce';

 

    Timestamp TIMESTAMP := current_timestamp;

 

    Executed BOOLEAN := true;

 

BEGIN

 

    -- Begin a transaction

 

    BEGIN

 

        -- Check if the script has been executed before

 

        IF NOT EXISTS (SELECT 1 FROM metadata."ControlTable" WHERE "ScriptName" = ScriptName AND "Version"= Version ) THEN

 

            -- Your SQL script logic here

 

            -- Example: Creating a table

                CREATE TABLE IF NOT EXISTS metadata."LoadError"
                (
                    "ScriptName" character(500),
                    "Version" integer,
                    "Description" character(500),
                    "Developer" character(500),
                    "ErrorMessage" character(500),
                    "ErrorTimestamp" timestamp(6) with time zone
                );



        END IF;

 


        -- Commit the transaction

 

--        COMMIT;

 

    EXCEPTION

 

        -- Handle any errors that occur

 

        WHEN OTHERS THEN

 

            -- Rollback the transaction

 

            ROLLBACK;


            -- Rethrow the error

 

            RAISE;

 

    END;
commit;
END$$;