#!/bin/bash
# A menu driven shell script sample template

RED='\033[0;41;30m'
STD='\033[0;0;39m'
GRN='\e[92m'
BLU='\e[104m'
YLW='\e[33m'

pause(){
    read -p "Press [Enter] key to continue..."
}

show_start_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - S T A R T - S E R V I C E \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Start task service ${STD}"
    echo -e "2. ${YLW} Start all services ${STD}"
}

start(){
    show_start_options
    local start_choice
    read -p "Enter choice [ 1 - 2 ] " start_choice
    read -p "Are you sure to start services[Y/y]? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        case $start_choice in
          1)
            echo "Starting task service..."
            python3 $HOME/sesto_backup_test/envoy_server_task/main.py &
            sleep 1
            echo "Started task service."
            pause
          ;;
          2)
            echo "Starting all services..."
            python3 $HOME/sesto_backup_test/envoy_server_task/main.py &
            sleep 1
            echo "Started all service."
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
    fi
}

show_stop_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - S T A R T - S E r V I C E \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Stop task service ${STD}"
    echo -e "2. ${YLW} Stop all services ${STD}"
}

stop(){
    show_stop_options
    local stop_choice
    read -p "Enter choice [ 1 - 2 ] " stop_choice
    read -p "Are you sure to stop services?[Y/y] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        case $stop_choice in
          1)
            echo "Stopping task service..."
            ps -ef | grep "envoy_server_task/main.py" | grep -v grep | awk '{print $2}' | xargs kill
            sleep 1
            echo "Stopped task service."
            pause
          ;;
          2)
            echo "Stopping all services..."
            killall
            sleep 1
            echo "Stopped all services."
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
    fi
}


killall(){
  read -p "Are you sure to stop all services?[Y/y] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo "Stopping services..."
      ps -ef | grep "envoy_server_task/main.py" | grep -v grep | awk '{print $2}' | xargs kill
    fi
}

restart(){
    read -p "Are you sure to restart services?[Y/y] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # do dangerous stuff
        echo "Restarting services..."
        killall
        sleep 1
        echo "Restarting all services..."
        start
        sleep 1
        pause
        echo "Restart done."
    fi

}


# function to display menus
show_menus() {
    echo "Refreshing..."
    clear
    check
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m M I C R O - S E R V I C E - M E N U \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${GRN} Start Application Servers ${STD}"
    echo -e "2. ${GRN} Stop Application Servers ${STD}"
    echo -e "3. ${GRN} Start Application Servers - Production version ${STD}"
    echo -e "4. ${GRN} Stop Application Servers - Production version ${STD}"
    echo -e "5. ${GRN} Restart Individual Application Server ${STD}"
    echo -e "6. ${GRN} Check running application servers ${STD}"
    echo -e "7. ${GRN} Upload data to database ${STD}"
    echo -e "8. ${GRN} Setup environment for all applications ${STD}"
    echo -e "9. ${GRN} Exit ${STD}"
}

# read input from the keyboard and take a action
read_options(){
    local choice
    read -p "Enter choice [ 1 - 9 ] " choice
    case $choice in
        1) start ;;
        2) stop ;;
        3) check ;;
        4) restart ;;
        5) checklog ;;
        6) monitperf ;;
        7) checkports ;;
        8) show_servicemenus ;;
        9) exit 0;;
        *) echo -e "${RED}Error...${STD}" && sleep 2
    esac
}

# ----------------------------------------------
# Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Main logic - infinite loop
# ------------------------------------
while true
do
    show_menus
    read_options
done

