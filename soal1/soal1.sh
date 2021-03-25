#ini nyoba, jangan dicontek. ntar bingung sendiri
echo "running"

errors=("Jan 31 00:09:39 ubuntu.local ticky: INFO Created ticket [#4217] (mdouglas)" "Jan 31 00:16:25 ubuntu.local ticky: INFO Closed ticket [#1754] (noel)" "Jan 31 00:21:30 ubuntu.local ticky: ERROR The ticket was modified while updating (breee)" "Jan 31 00:44:34 ubuntu.local ticky: ERROR Permission denied while closing ticket (ac)")
datasource_re='([[:alnum:]]+) ubuntu.local ticky: ([[:alnum:]]+)'
for errorLogLine in "${errors[@]}"; do
  if [[ "$errorLogLine" =~ $datasource_re ]]; then
    echo "Found source: ${BASH_REMATCH[2]}"
    if [[ ${BASH_REMATCH[2]}=="ERROR" ]]; then
        echo "ini error"
    else
        echo "ini info"
    fi
  else echo "no match in $errorLogLine"
  fi
done

echo "completed"