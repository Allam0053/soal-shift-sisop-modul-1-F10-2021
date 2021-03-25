#!/usr/bin/env bash

echo -e "running\n"

errors=("Jan 31 00:09:39 ubuntu.local ticky: INFO Created ticket [#4217] (mdouglas)" 
        "Jan 31 00:09:39 ubuntu.local ticky: INFO Created ticket [#4217] (mdouglas)" 
        "Jan 31 00:16:25 ubuntu.local ticky: INFO Closed ticket [#1754] (noel)" 
        "Jan 31 00:21:30 ubuntu.local ticky: ERROR The ticket was modified while updating (breee)"
        "Jan 31 00:21:30 ubuntu.local ticky: ERROR The ticket was modified while updating (breee)"
        "Jan 31 00:44:34 ubuntu.local ticky: ERROR Permission denied while closing ticket (ac)"
        "Jan 31 00:44:34 ubuntu.local ticky: ERROR Permission denied while closing ticket (ac)"
        "Jan 31 03:47:24 ubuntu.local ticky: ERROR Ticket doesn't exist (enim.non)")
datasource_re='([[:alnum:]]+) ([[:alnum:]]+) ([[:alnum:]]+):([[:alnum:]]+):([[:alnum:]]+) ([ [:punct:][:alnum:]]+) ([[:alnum:]]+): ([[:alnum:]]+) ([][ #0-9A-Za-z]+) ([(]+)([.0-9A-Za-z]+)([)]+)'

user=()
errorKind=("")
errorKindSum=("")
#=========================get the error============================================#
for errorLogLine in "${errors[@]}"; do
  if [[ "$errorLogLine" =~ $datasource_re ]]; then
    #collect error=================================================================#
    if [[ "${BASH_REMATCH[8]}" == "ERROR"  ]]; then
        user+=("${BASH_REMATCH[9]}")
        for i in "${!errorKind[@]}"; do
            if [[ "${errorKind[$i]}" == "${BASH_REMATCH[9]}" ]]; then
                errorKindSum[$i]=$((${errorKindSum[$i]}+1))
                flag=0
                break
            else
                flag=1
            fi
        done
        if [[ $flag == 1 ]]; then
            errorKind[${#errorKind[@]}]="${BASH_REMATCH[9]}"
            errorKindSum[${#errorKindSum[@]}]=1
        fi
    fi
    #collect user=================================================================#
    
  fi
done
#=========================/get the error============================================#

for i in "${!errorKind[@]}"; do
    if [[ $i == 0 ]]; then
        continue
    fi
    echo "${errorKind[$i]}: ${errorKindSum[$i]}"
done

echo -e "\ncompleted\n"

declare -A serviceList
listService(){
    serviceList["$1"]=$2
}

for i in "${!errorKind[@]}"; do
    if [[ $i == 0 ]]; then
        continue
    fi
    
    if [[ ${serviceList[${errorKindSum[$i]}]} == "" ]]; then
        serviceList["${errorKindSum[$i]}"]="${errorKind[$i]}"
    else
        serviceList["${errorKindSum[$i]}"]="${serviceList[${errorKindSum[$i]}]},${errorKind[$i]}"
    fi
done

# listService ${errorKindSum[1]} "${errorKind[1]}"
# listService ${errorKindSum[$i]} "${errorKind[$i]}"
# listService serviceTypeB
# listService serviceTypeC

for key in ${!serviceList[@]}
do
    echo "\"$key\": ${serviceList[$key]}"
done

IFS="|"
arr2=( $(
    for i in "${!errorKind[@]}"
    do
        if [[ $i == 0 ]]; then
            continue
        fi
        echo "${errorKind[$i]}"
    done | sort) )

echo "${arr2[0]}"
reg='([][ #0-9A-Za-z]+)([,]+)'
for errorLogLine in "${arr2[@]}"; do
  if [[ "$errorLogLine" =~ "$reg" ]]; then
    echo "${BASH_REMATCH[0]}..."
  fi
done



# for i in "${errorKind[@]}"; do
#     echo "$i..."
# done

# arr2=( $(
#     for el in "${user[@]}"
#     do
#         echo "$el"
#     done | sort) )

# for value in "${arr2[@]}"
# do
#      echo "$value"
# done
# echo "category: ${BASH_REMATCH[6]}"
# echo "message: ${BASH_REMATCH[7]}"
# echo "user: ${BASH_REMATCH[9]}"
# if [[ ${BASH_REMATCH[6]} == "ERROR" ]]; then
#     echo -e "ini erroror\n"
# else
#     echo -e "ini info\n"
# fi
# =============================================================================================================================================================================================== ===============================================================================================================================================================================================
# =============================================================================================================================================================================================== ===============================================================================================================================================================================================
# =============================================================================================================================================================================================== ===============================================================================================================================================================================================
# =============================================================================================================================================================================================== ===============================================================================================================================================================================================

  
#!/bin/bash

# Sangat bisa untuk disederhanakan lagi
# versi 2

declare -A messages
declare -A users_info
declare -A users_error

index_result=()
users=()

input_file=syslog.log
output_file_1=error_message.csv
output_file_2=user_statistic.csv

checkLinesForUser()
{
    line=${1##*(}
    user=${line%)*}
    if [[ ! "${users[@]}" = *$user* ]]
    then
        users+=("$user")
        user_info=$(grep -i "($user)" $input_file | grep -wc "INFO")
        user_error=$(grep -i "($user)" $input_file | grep -wc "ERROR")
        users_info+=(["$user"]=$user_info)
        users_error+=(["$user"]=$user_error)
    fi
}

checkLinesForError()
{
    if [[ "$1" = *ERROR* ]]
    then
        line=${1##*ERROR }
        message=${line% (*}
        if [[ ! "${messages[@]}" = *${message}* ]]
        then
            index=$(grep -wc "$message" $input_file)
            messages+=([$index]="$message")
            index_result+=($index)
        fi
    fi
}

while read lines
do
    checkLinesForUser "$lines"
    checkLinesForError "$lines"
done < $input_file

index_result=($(echo ${index_result[*]}| tr " " "\n" | sort -n))
users=($(echo ${users[*]}| tr " " "\n" | sort -n))

echo "Error,Count" > $output_file_1
for (( i = `expr ${#index_result[@]} - 1`; i >= 0; i--))
do
    echo "${messages[${index_result[$i]}]},${index_result[$i]}" >> $output_file_1
done

echo "Username,INFO,ERROR" > $output_file_2
for user in ${users[@]}
do
    echo "${user},${users_info[$user]},${users_error[$user]}" >> $output_file_2
done