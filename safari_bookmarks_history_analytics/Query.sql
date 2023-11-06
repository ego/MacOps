-- DIFF: (history_visits + history_items) || saved_tabs_table_name
-- Change to YOURS CRASH DATES in line: 27
-- Change to YOURS table FROM ... in line: 41
SELECT
    h.domain_expansion,
    unique_rows.base_url,
    RTRIM(h.url, '/') as url,
    date(v.visit_time + 978307200, 'unixepoch', 'localtime')  as visit_date,
    datetime(v.visit_time + 978307200, 'unixepoch', 'localtime')  as visit_time,
    v.title,
    h.id as h_id,
    v.id as v_id
FROM history_visits as v
JOIN history_items as h ON v.history_item = h.id 
JOIN (
    SELECT
        CASE
            WHEN SUBSTR(h.url, 1, INSTR(h.url, '?') - 1) = '' THEN RTRIM(h.url, '/')
            ELSE RTRIM(SUBSTR(h.url, 1, INSTR(h.url, '?') - 1), '/')
        END AS base_url,
        MAX(h.id) AS max_h_id,
        MAX(v.id) AS max_v_id
    FROM history_visits AS v
    JOIN history_items AS h ON v.history_item = h.id 
    WHERE 
      date(v.visit_time + 978307200, 'unixepoch', 'localtime')
        -- Change to YOURS CRASH DATES
        IN (date('2023-08-17'), date('2023-08-14'))
    GROUP BY 1 
    ORDER BY v.visit_time
    -- LIMIT 20
) AS unique_rows 
  ON unique_rows.max_h_id = h.id
    AND unique_rows.max_v_id = v.id
LEFT JOIN (
    SELECT
        CASE
            WHEN SUBSTR(url_string, 1, INSTR(url_string, '?') - 1) = '' THEN RTRIM(url_string, '/')
            ELSE RTRIM(SUBSTR(url_string, 1, INSTR(url_string, '?') - 1), '/')
        END AS base_url
    FROM saved_tabs_29_08_2023
    GROUP BY 1 
    ORDER BY positional_index
) AS tabs
  ON tabs.base_url = unique_rows.base_url
WHERE
    tabs.base_url IS NULL
    AND unique_rows.base_url NOT LIKE '%google.com/search%'
    AND unique_rows.base_url NOT LIKE '%translate.google.com%'
    AND unique_rows.base_url NOT LIKE '%instagram.com%'
    AND unique_rows.base_url NOT LIKE '%facebook.com%'
    AND unique_rows.base_url NOT LIKE '%google.com/gmail/%'
    AND unique_rows.base_url NOT LIKE '%google.com/intl/ru_ALL/drive/%'
    AND unique_rows.base_url NOT LIKE '%xbet.com%'
    AND unique_rows.base_url NOT LIKE 'https://developers.google.com/s/results/%'
    AND unique_rows.base_url NOT LIKE 'https://www.google.com/imgres%'
    AND unique_rows.base_url NOT LIKE 'https://www.google.com/maps%'
    AND unique_rows.base_url NOT LIKE '%google.com/url?q%'
    AND unique_rows.base_url NOT LIKE 'https://www.google.com/search?%'
    AND unique_rows.base_url NOT LIKE '%lun.ua/%'
    AND unique_rows.base_url NOT LIKE '%accounts.youtube.com/accounts/%'
    AND unique_rows.base_url NOT LIKE '%bing.com%'
    AND unique_rows.base_url NOT LIKE '%://booking.com%'
    AND unique_rows.base_url NOT LIKE '%://www.google.com/intl/%'
    AND unique_rows.base_url NOT LIKE '%://www.google.com/intl/%'
    AND h.domain_expansion NOT IN (
        'calendar.google',
        'drive.google',
        'outlook.office',
        'mail.google',
        'contacts.google',
        'accounts.google',
        'analytics.google',
        'console.aws.amazon',
        'signin.aws.amazon',
        'docs.google',
        'boto3.amazonaws',
        'vitagramma',
        'twitter',
        'myaccount.google',
        'dropbox',
        'forums.docker',
        'docs.docker',
        'ads.google',
        'dom.ria',
        'forbes',
        'docs.ansible',
        'email.awscloud',
        'glassdoor',
        'googleadservices',
        'kyivlambda',
        'login.microsoftonline',
        'login.skype',
        'maps.google',
        'meet.google',
        'photos.google',
        'quora',
        'secure.skype',
        'secure.wayforpay',
        'secureconv-dl',
        'serverfault',
        'simloud.slack',
        'support.apple',
        'truveris',
        'ua.trovit',
        'upwork',
        'wall-street',
        'wsj',
        'z.cdn.braun634',
        'marketplace.atlassian',
        'nedviga-invest',
        'gsuite.google',
        'linkedin',
        'gds.google',
        'verywellcafe-dn.choiceqr',
        '3ds2-idcheck.acdcproc'
    )
;
