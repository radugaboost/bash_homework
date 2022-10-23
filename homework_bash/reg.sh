#!/bin/bash
flag_f=0
flag_op=0
while [[ $flag_f -ne 1 ]]
do
    flag_p=0
    read -p "Введите логин: " login_inp
    len_login=${#login_inp}
    if [[ $len_login -gt 1 ]]
    then
    while read line
    do
        if [[ $login_inp == $line ]]
        then
            flag_p=1
        fi
    done < database
    if [[ $flag_p == 0 ]]
    then
    while [[ $flag_op -eq 0 ]]
    do
        read -p "Введите пароль: " pswd
        len_pswd=${#pswd}
        if [[ $len_pswd -gt 1 ]]
        then
        echo "Вы успешно зарегистрировались!" 
        echo $login_inp >> database 
        echo $pswd | md5sum >> database
        flag_op=1
        flag_f=1
        else
            echo "Пароль должен содержать больше 1 символа!"
        fi
    done
    else
        echo "Такой логин уже занят!"
        echo "Какой-то дурак ввел занятый логин..($login_inp)">>reg_errors
    fi
    else
        echo "В логине должно быть больше 1 символа!"
        echo "Дурак ввёл слишком короткий логин!" >> reg_errors
    fi
done