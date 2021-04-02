in_f=syslog.log
output_file_1=error_message.csv
output_file_2=user_statistic.csv

error_count=0
info_count=0 #a

error_kind=("")
error_kind_sum=(0)
error_kind_sum_sort=(0)
error_pattern='ERROR ([[:punct:][:alnum:]]+)'

user_name=("")
user_info=(0)
user_error=(0)
user_string_sort=("")

while read in_line; do
    if [[ "$in_line" =~ $error_pattern ]]; then
        error_count=$(($error_count+1))
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
    else
        info_count=$(($info_count+1))
    fi

    line=${in_line##*(}
    user=${line%)*}

    for i in "${!user_name[@]}"; do
        if [[ "${user_name[$i]}" == "$user" ]]; then
            if [[ $in_line =~ "INFO" ]]; then
                user_info[$i]=$((${user_info[$i]}+1))
            else
                user_error[$i]=$((${user_error[$i]}+1))
            fi
            flaguser=0
            break
        else
            flaguser=1
        fi
    done
    if [[ $flaguser == 1 ]]; then
        user_name[${#user_name[@]}]="$user"
        if [[ $in_line =~ "INFO" ]]; then
            user_info[${#user_info[@]}]=1
            user_error[${#user_error[@]}]=0
        else
            user_info[${#user_info[@]}]=0
            user_error[${#user_error[@]}]=1
        fi
    fi
    
done < $in_f

#sorting
echo "Error,Count" > $output_file_1
for i in "${!error_kind_sum[@]}"; do
    if [[ $i == 0 ]]; then
        continue
    fi
    error_kind_sum_sort[${#error_kind_sum_sort[@]}]=${error_kind_sum[$i]}
done
error_kind_sum_sort=($(echo ${error_kind_sum_sort[*]}| tr " " "\n" | sort -n)) #-r for descending

#print
for ((i=${#error_kind_sum_sort[@]}; i>=1; i=i-1))
do
    for j in "${!error_kind_sum[@]}"; do
        if [[ $j == 0 ]]; then
            continue
        fi
        if [[ "${error_kind_sum_sort[$i]}" =~ "${error_kind_sum[$j]}" ]]; then
            echo "${error_kind[$j]}, ${error_kind_sum[$j]}" #b
            echo "${error_kind[$j]}, ${error_kind_sum[$j]}" >> $output_file_1 #d
            continue
        fi
    done
done

#sorting
for i in "${!user_name[@]}"; do
    if [[ $i == 0 ]]; then
        continue
    fi
    user_string_sort[${#user_string_sort[@]}]="${user_name[$i]},${user_info[$i]},${user_error[$i]}"
done
user_string_sort=($(echo ${user_string_sort[*]}| tr " " "\n" | sort -n))

#print
echo "Username,INFO,ERROR" > $output_file_2
for i in "${!user_name[@]}"; do
    if [[ $i == 0 ]]; then
        continue
    elif [[ "${user_string_sort[$i]}" == "" ]]; then
        continue
    fi
    echo "${user_string_sort[$i]}" #c
    echo "${user_string_sort[$i]}" >> $output_file_2 #e
done