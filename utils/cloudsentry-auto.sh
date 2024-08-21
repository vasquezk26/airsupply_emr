function refresh_credentials ()
{
    if ! [ -f $HOME/.aws/credentials ]; then
        echo "AWS credentials not found"
        return 1
    fi

    while read line; do

        # Refresh credentials if needed
        if [[ $line == token_expiration* ]]; then
            # echo $line | awk -F' = ' '{print $2}'
            stale=$(python -c "import sys, datetime; from dateutil import parser; print(parser.isoparse(sys.argv[1]).astimezone(tz=None) < datetime.datetime.now().astimezone(tz=None))" $(echo $line | awk -F' = ' '{print $2}'))
            if [[ "$stale" == "True" ]]; then
                echo "AWS credentials are expired. Refreshing now..."
                cloudsentry access get --all --ba BATRADECREDITDATASERVICES --force
            elif [[ "$stale" == "False" ]]; then
                # AWS credentials are valid
                return 0
            else
                echo "Error with refreshing token. Mismatched arguments:"
                python -c "import sys; print('\t', sys.argv)" $line
                return 1
            fi
            break
        fi

    done < $HOME/.aws/credentials
}