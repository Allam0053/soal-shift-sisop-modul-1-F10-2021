in_f="syslog.log"
output_file_1=error_message.csv
output_file_2=user_statistic.csv

error_kind=("")
error_kind_sum=(0)
error_pattern='ERROR ([[:punct:][:alnum:]]+)'

#=================================ERROR LOG====================================
while read in_line; do
    if [[ "$in_line" =~ $error_pattern ]]; then
        line=${in_line##*ERROR } #extract string setelah "ERROR"
        kind=${line% (*}
        for i in "${!error_kind[@]}"; do
            if [[ "${error_kind[$i]}" == "$kind" ]]; then
                error_kind_sum[$i]=$((${error_kind_sum[$i]}+1))
                flag=0
                break
            else
                flag=1
            fi
        done
        if [[ $flag == 1 ]]; then
            error_kind[${#error_kind[@]}]="$kind"
            error_kind_sum[${#error_kind_sum[@]}]=1
        fi
    fi
    
done < $in_f

echo "Error,Count" > $output_file_1
for i in "${!error_kind[@]}"; do
    if [[ $i == 0 ]]; then
        continue
    fi
    echo "${error_kind[$i]}: ${error_kind_sum[$i]}" >> $output_file_1
done
#=================================/ERROR LOG====================================

#=================================USER INFO=====================================
echo "Username,INFO,ERROR" > $output_file_2
