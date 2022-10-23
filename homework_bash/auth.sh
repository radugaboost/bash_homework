#!/bin/bash
exec 2>>log
cnt=3
flag_f=0
while [[ $flag_f -eq 0 ]]
do
    echo "Введите логин: " 
    read user_inp
    flag_p=0
    flag_g=0
    flag_y=0
    flag_ph=0
    while read line
    do
    if [[ $flag_p -eq 1 ]]
    then
        pswd=$line
        flag_p=0
        flag_y=1
    fi
    if [[ $user_inp == $line ]]
    then
        flag_p=1
        flag_a=1
    fi
    done < database
    if [[ $flag_a -eq 0 ]]
    then
        echo "Такого логина нет!"
        echo "Какой то дурак ввел несуществующий логин($user_inp)" >> auth_errors
    fi
    while [[ $flag_y -eq 1 ]]
    do
        if [[ $cnt -eq 0 ]]
        then
            echo "Какой то дурак так и не смог авторизоваться(ha-ha)" >> auth_errors
            fswebcam -r 640x480 --jpeg 85 -D 1 web-cam-shot.jpg
            mv web-cam-shot.jpg /home/daniil/BASHHHHH/homework_bash/pictures_of_fools
            flag_f=1
            flag_ph=1
            break
        fi
        echo "Введите пароль: "
        read -t 15 -s user_pswd
        echo $user_pswd | md5sum > check_pswd
        while read lines
        do
        if [[ $lines == $pswd ]]
        then
            echo "Вы успешно авторизовались!"
            flag_f=1
            flag_y=0
        else
            cnt=$(($cnt-1))
            echo "Вы ввели неверный пароль! Осталось попыток: $cnt"
            echo "Какой то дурак ввел неправильный пароль" >> auth_errors
        fi
        done < check_pswd
    done
    if [[ $flag_ph -eq 1 ]]
    then
        echo "Ищи себя в прошмандовках Азербайджана!"
        echo "Дурак сфотографирован!" >> auth_errors
    fi
done