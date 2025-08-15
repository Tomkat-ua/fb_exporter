        SELECT 'active_transactions' as counter_name, count(*) as cntr_value
        FROM MON$TRANSACTIONS WHERE MON$STATE = 1
        UNION
        SELECT 'open_connections' as counter_name, count(*) as cntr_value
        FROM MON$ATTACHMENTS UNION
        SELECT 'idle_connections' as counter_name, count(*) as cntr_value
        FROM MON$ATTACHMENTS
        WHERE MON$STATE = 0 UNION
        SELECT 'database_state' as counter_name, MON$SHUTDOWN_MODE as cntr_value
        FROM MON$DATABASE UNION
        SELECT 'pages_allocated_externally' as counter_name, MON$PAGES as cntr_value
        FROM MON$DATABASE UNION
        SELECT 'page_fetches' as counter_name, MON$PAGE_FETCHES as cntr_value
        FROM MON$IO_STATS
        WHERE MON$STAT_GROUP = 0  UNION
         SELECT 'page_writes' as counter_name, MON$PAGE_WRITES as cntr_value
         FROM MON$IO_STATS
         WHERE MON$STAT_GROUP = 0 UNION
         SELECT 'database_memory_used' as counter_name, MON$MEMORY_USED as cntr_value
         FROM MON$MEMORY_USAGE
         WHERE MON$STAT_GROUP = 0 UNION
         SELECT 'database_page_size' as counter_name, MON$PAGE_SIZE as cntr_value
         FROM MON$DATABASE UNION
         SELECT 'database_allocated_pages' as counter_name, MON$PAGE_BUFFERS as cntr_value
         FROM MON$DATABASE UNION
         SELECT 'stalled_statements' as counter_name, count(*) as cntr_value
         FROM MON$STATEMENTS
         WHERE MON$STATE = 2 UNION
         SELECT 'running_statements' as counter_name, count(*) as cntr_value
         FROM MON$STATEMENTS
         WHERE MON$STATE = 1 AND MON$ATTACHMENT_ID <> CURRENT_CONNECTION UNION
         SELECT 'oldest_active' as counter_name, MON$OLDEST_ACTIVE as cntr_value
         FROM MON$DATABASE UNION
         SELECT 'oldest_snapshot' as counter_name, MON$OLDEST_SNAPSHOT as cntr_value
         FROM MON$DATABASE UNION
         SELECT 'next_transaction' as counter_name, MON$NEXT_TRANSACTION as cntr_value
         FROM MON$DATABASE  UNION
         SELECT 'database_duration_seconds' as counter_name, DATEDIFF(second, MON$CREATION_DATE, current_timestamp) as cntr_value
         FROM MON$DATABASE union
         select 'DATABASE_SIZE' ,m.mon$page_size * m.mon$pages as bytes
         from mon$database m
