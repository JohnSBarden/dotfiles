SELECT 
    groups.account_id,
    groups.account_name,
    parent.account_name parent_account,
    groups.first_name account_owner_first,
    groups.last_name account_owner_last,
    groups.email account_owner_email,
    users.first_name first_name,
    users.last_name last_name,
    users.email email,
    IF((groups.exp_date IS NULL
            AND groups.sub_exp_date IS NULL
            AND groups.trial_exp_date IS NULL
            AND groups.mm_merchandiser_exp_date IS NULL
            AND groups.mm_producer_exp_date IS NULL
            AND groups.yf_sc_exp_date IS NULL
            AND groups.yf_producer_exp_date IS NULL),
        NULL,
        (GREATEST(IF(groups.exp_date IS NULL,
                    '0',
                    groups.exp_date),
                IF(groups.sub_exp_date IS NULL,
                    '0',
                    groups.sub_exp_date),
                IF(groups.trial_exp_date IS NULL,
                    '0',
                    groups.trial_exp_date),
                IF(groups.mm_merchandiser_exp_date IS NULL,
                    '0',
                    groups.mm_merchandiser_exp_date),
                IF(groups.mm_producer_exp_date IS NULL,
                    '0',
                    groups.mm_producer_exp_date),
                IF(groups.yf_sc_exp_date IS NULL,
                    '0',
                    groups.yf_sc_exp_date),
                IF(groups.yf_producer_exp_date IS NULL,
                    '0',
                    groups.yf_producer_exp_date)))) latest_exp_date
FROM
    prod.groups
        LEFT JOIN
    groups parent ON (parent.account_id = groups.parent_account_id)
        LEFT JOIN
    users ON (users.group_id = groups.group_id)
    
    where groups.account_id not in (10000, 10001, 10176)
    
    order by latest_exp_date asc
    limit 1000000