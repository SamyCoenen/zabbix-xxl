#!/bin/bash

# Slack incoming web-hook URL and user name
url='CHANGEME'# example     : https://hooks.slack.com/services/QW3R7Y/D34DC0D3/BCADFGabcDEF123
username='Zabbix'

## Values received by this script:
# To = ( (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = [ (usually either PROBLEM or RECOVERY)
# Message = { (whatever message the Zabbix action sends, preferably something like "Zabbix server is unreachable for 5 minutes - Zabbix server (127.0.0.1)")

# Get the Slack channel or user (() and Zabbix subject ([ - hopefully either PROBLEM or RECOVERY)
to="("
subject="["

# Change message emoji depending on the subject - smile (RECOVERY), frowning (PROBLEM), or ghost (for everything else)
recoversub='^RECOVER(Y|ED)?$'
if [[ "$subject" =~ ${recoversub} ]]; then
        emoji=':smile:'
    elif [ "$subject" == 'PROBLEM' ]; then
            emoji=':frowning:'
        else
                emoji=':ghost:'
            fi
            
            # The message that we want to send to Slack is the "subject" value ([ / $subject - that we got earlier)
            #  followed by the message that Zabbix actually sent us ({)
        message="${subject}: {"
    
    # Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="payload={\"channel\": \"${to//\"/\\\"}\", \"username\": \"${username//\"/\\\"}\", \"text\": \"${message//\"/\\\"}\", \"icon_emoji\": \"${emoji}\"}"
curl -m 5 --data-urlencode "${payload}" $url -A 'zabbix-slack-alertscript / https://github.com/ericoc/zabbix-slack-alertscript'}}]])])}])
