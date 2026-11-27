/* ============================================================================
   SMB Data Governance Catalog — Automated Field Dictionary Extractor
   Purpose: Extracts table and column metadata from PostgreSQL or MySQL 
            formatted to paste directly into '2_Field_Dictionary' (Excel).
   Author:  Shawn Carron (DataNorth Analytics)
   ============================================================================ */

-- ============================================================================
-- OPTION A: POSTGRESQL VERSION
-- Replace 'public' with your target schema name (e.g., 'sales', 'crm')
-- ============================================================================
SELECT 
    'AST-TBD'                                           AS "Asset_ID",
    c.table_name                                        AS "Asset_Name",
    c.column_name                                       AS "Field_Name",
    CASE 
        WHEN c.character_maximum_length IS NOT NULL 
            THEN UPPER(c.data_type) || '(' || c.character_maximum_length || ')'
        WHEN c.numeric_precision IS NOT NULL AND c.data_type = 'numeric'
            THEN 'NUMERIC(' || c.numeric_precision || ',' || COALESCE(c.numeric_scale, 0) || ')'
        ELSE UPPER(c.data_type)
    END                                                 AS "Data_Type",
    COALESCE(pgd.description, 'Needs business definition') AS "Business_Definition",
    CASE 
        WHEN LOWER(c.column_name) ~ '(email|phone|ssn|sin|dob|birth|address|postal|zip|first_name|last_name|full_name|password|credit|card|ip_address)'
            THEN 'Yes'
        ELSE 'No'
    END                                                 AS "Contains_PII",
    'Extracted from PostgreSQL (' || c.table_schema || '.' || c.table_name || ')' AS "Source_Logic",
    CASE 
        WHEN c.is_nullable = 'NO' THEN 'NOT NULL'
        ELSE 'Nullable'
    END                                                 AS "Validation_Rules"
FROM information_schema.columns c
LEFT JOIN pg_catalog.pg_statio_all_tables st 
    ON c.table_schema = st.schemaname 
    AND c.table_name = st.relname
LEFT JOIN pg_catalog.pg_description pgd 
    ON pgd.objoid = st.relid 
    AND pgd.objsubid = c.ordinal_position
WHERE c.table_schema = 'public'
ORDER BY c.table_name, c.ordinal_position;


-- ============================================================================
-- OPTION B: MYSQL VERSION
-- Replace DATABASE() with a specific schema name in quotes if needed
-- ============================================================================
/*
SELECT 
    'AST-TBD'                                           AS Asset_ID,
    c.TABLE_NAME                                        AS Asset_Name,
    c.COLUMN_NAME                                       AS Field_Name,
    UPPER(c.COLUMN_TYPE)                                AS Data_Type,
    COALESCE(NULLIF(c.COLUMN_COMMENT, ''), 'Needs business definition') AS Business_Definition,
    CASE 
        WHEN LOWER(c.COLUMN_NAME) REGEXP '(email|phone|ssn|sin|dob|birth|address|postal|zip|first_name|last_name|full_name|password|credit|card|ip_address)'
            THEN 'Yes'
        ELSE 'No'
    END                                                 AS Contains_PII,
    CONCAT('Extracted from MySQL (', c.TABLE_SCHEMA, '.', c.TABLE_NAME, ')') AS Source_Logic,
    TRIM(BOTH '; ' FROM CONCAT(
        CASE WHEN c.IS_NULLABLE = 'NO' THEN 'NOT NULL; ' ELSE '' END,
        CASE WHEN c.COLUMN_KEY = 'PRI' THEN 'PRIMARY KEY; ' ELSE '' END,
        CASE WHEN c.COLUMN_KEY = 'UNI' THEN 'UNIQUE; ' ELSE '' END
    ))                                                  AS Validation_Rules
FROM information_schema.COLUMNS c
WHERE c.TABLE_SCHEMA = DATABASE()
ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION;
*/
