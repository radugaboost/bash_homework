#!/bin/bash
flag_f=0
while [[ $flag_f -ne 1 ]]
do
    flag_p=0
    read -p "Введите логин: " login_inp
    while read line
    do
        if [[ $login_inp == $line ]]
        then
            flag_p=1
        fi
    done < database
    if [[ $flag_p == 0 ]]
    then
        read -p "Введите пароль: " pswd
        echo "Вы успешно зарегистрировались!" 
        echo $login_inp >> database 
        echo $pswd | md5sum >> database
        flag_f=1
    else
        echo "Такой логин уже занят!"
        echo "Какой-то дурак ввел занятый логин..($login_inp)">>reg_errors
    fi
done