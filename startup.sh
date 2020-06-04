#!/bin/bash
# A menu driven shell script sample template

RED='\033[0;41;30m'
STD='\033[0;0;39m'
GRN='\e[92m'
BLU='\e[104m'
YLW='\e[33m'
sesto_folder_name=sesto_backup_test
task_log_file=$HOME/$sesto_folder_name/envoy_server_task/task.log
manager_log_file=$HOME/$sesto_folder_name/envoy_server_manager/manager.log
ensemble_log_file=$HOME/$sesto_folder_name/envoy_server_ensemble/ensemble.log

pause(){
    read -p "Press [Enter] key to continue..."
}

show_start_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - S T A R T - S E R V I C E \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Start task service ${STD}"
    echo -e "2. ${YLW} Start ensemble service ${STD}"
    echo -e "3. ${YLW} Start manager service ${STD}"
    echo -e "4. ${YLW} Start all services ${STD}"
}

start_task_service(){
  echo "Starting task service..."
  python3 $HOME/$sesto_folder_name/envoy_server_task/main.py >> $task_log_file.$(date "+%Y.%m.%d-%H.%M.%S") 2>&1 &
  sleep 1
  echo "Started task service."
}

start_ensemble_service(){
  echo "Starting ensemble service..."
  python3 $HOME/$sesto_folder_name/envoy_server_ensemble/main.py >> $ensemble_log_file.$(date "+%Y.%m.%d-%H.%M.%S") 2>&1 &
  sleep 1
  echo "Started ensemble service."
}

start_manager_service(){
  echo "Starting manager service..."
  python3 $HOME/$sesto_folder_name/envoy_server_manager/main.py >> $manager_log_file.$(date "+%Y.%m.%d-%H.%M.%S") 2>&1 &
  sleep 1
  echo "Started manager service."
}

start_all_services(){
  echo "Starting all services..."
  start_task_service
  start_ensemble_service
  start_manager_service
  echo "Started all service."
}

start(){
    show_start_options
    local start_choice
    read -p "Enter choice [ 1 - 4 ] " start_choice
    read -p "Are you sure to start services[Y/y]? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        case $start_choice in
          1)
            start_task_service
            pause
          ;;
          2)
            start_ensemble_service
            pause
          ;;
          3)
            start_manager_service
            pause
          ;;
          4)
            start_all_services
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
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - S T O P - S E R V I C E \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Stop task service ${STD}"
    echo -e "2. ${YLW} Stop ensemble services ${STD}"
    echo -e "3. ${YLW} Stop manager services ${STD}"
    echo -e "4. ${YLW} Stop all services ${STD}"
}

stop_task_service(){
  echo "Stopping task service..."
   ps -ef | grep "envoy_server_task/main.py" | grep -v grep | awk '{print $2}' | xargs kill
   sleep 1
   echo "Stopped task service."
}

stop_ensemble_service(){
  echo "Stopping ensemble service..."
  ps -ef | grep "envoy_server_ensemble/main.py" | grep -v grep | awk '{print $2}' | xargs kill
  sleep 1
  echo "Stopped ensemble service."
}

stop_manager_service(){
  echo "Stopping manager service..."
  ps -ef | grep "envoy_server_manager/main.py" | grep -v grep | awk '{print $2}' | xargs kill
  sleep 1
  echo "Stopped manager service."
}

stop(){
    show_stop_options
    local stop_choice
    read -p "Enter choice [ 1 - 4 ] " stop_choice
    read -p "Are you sure to stop services?[Y/y] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        case $stop_choice in
          1)
            stop_task_service
            pause
          ;;
          2)
            stop_ensemble_service
            pause
          ;;
          3)
            stop_manager_service
            pause
          ;;
          4)
            killall
            sleep 1
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
    fi
}

start_production(){
  read -p "Are you sure to start all production services?[Y/y] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "Starting all production services..."
  fi
}

stop_production(){
  read -p "Are you sure to stop all production services?[Y/y] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "Stopping all production services..."
  fi
}

killall(){
  read -p "Are you sure to stop all services?[Y/y] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo "Stopping all services..."
      stop_task_service
      stop_ensemble_service
      stop_manager_service
      sleep 1
    fi
}

show_restart_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - R E S T A R T - S E R V I C E \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Restart task service ${STD}"
    echo -e "2. ${YLW} Restart ensemble services ${STD}"
    echo -e "3. ${YLW} Restart manager services ${STD}"
    echo -e "4. ${YLW} Restart all services ${STD}"
}

restart(){
  show_restart_options
    local restart_choice
    read -p "Enter choice [ 1 - 3 ] " restart_choice
    read -p "Are you sure to restart services?[Y/y] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        case $restart_choice in
          1)
            stop_task_service
            start_task_service
            sleep 1
            pause
          ;;
          2)
            stop_ensemble_service
            start_ensemble_service
            sleep 1
            pause
          ;;
          3)
            stop_manager_service
            start_manager_service
            sleep 1
            pause
          ;;
          4)
            killall
            start_all_services
            sleep 1
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
    fi
}

database_update(){
  local path
  read -p "Enter the path of the python file to update data to the database: " path
  echo
  python3 $path
  echo "Added to DB"

}

setup_task_environment(){
  echo "Setting up environment for task"
  cd $HOME/$sesto_folder_name/envoy_server_task
  inv -c devops environment.setup
  echo "Done setting up environment for task"
}

setup_ensemble_environment(){
  echo "Setting up environment for ensemble"
  cd $HOME/$sesto_folder_name/envoy_server_ensemble
  invoke -c devops environment.setup-mongodb
  invoke -c devops environment.setup
  echo "Done setting up environment for ensemble"
}

setup_manager_environment(){
  echo "Setting up environment for manager"
  cd $HOME/$sesto_folder_name/envoy_server_manager
  invoke -c devops environment.setup
  echo "Done setting up environment for manager"
}

setup_environment(){
  echo -e "Please make sure virual environment is activated before running this command"
  read -p "Are you sure virtual environment is activated?[Y/y] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo "Setting up invoke and poetry"
      pip install -U invoke poetry pip
      echo "Done setting up invoke and poetry successfully. Now setting up environment"
      sleep 1
      setup_task_environment
      sleep 1
#      setup_ensemble_environment
      sleep 1
      setup_manager_environment
      echo "Successfully setup environment for all modules"
  fi
  sleep 1
}

show_unit_test_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - U N I T T E S T - O P T I O N S \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Run unit tests for task service ${STD}"
    echo -e "2. ${YLW} Run unit tests for ensemble services ${STD}"
    echo -e "3. ${YLW} Run unit tests for manager services ${STD}"
}

run_unit_tests(){
  show_unit_test_options
    local unit_test_choice
    read -p "Enter choice [ 1 - 2 ] " unit_test_choice
    echo    # (optional) move to a new line
    case $unit_test_choice in
          1)
            echo "Running unittest for task service"
            cd $HOME/$sesto_folder_name/envoy_server_task
            invoke -c devops test.tests
            echo "Successfully ran unittest for task service"
            sleep 1
            pause
          ;;
          2)
            echo "Running unittest for ensemble service"
            cd $HOME/$sesto_folder_name/envoy_server_ensemble
            invoke -c devops test.tests
            echo "Successfully ran unittest for ensemble service"
            sleep 1
            pause
          ;;
          3)
            echo "Running unittest for manager service"
            cd $HOME/$sesto_folder_name/envoy_server_manager
            invoke -c devops test.tests
            echo "Successfully ran unittest for manager service"
            sleep 1
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
}

show_document_generation_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - D O C U M E N T - G E N E R A T I O N - O P T I O N S \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Generate documents for task service ${STD}"
    echo -e "2. ${YLW} Generate documents for ensemble services ${STD}"
    echo -e "3. ${YLW} Generate documents for manager services ${STD}"
}

generate_documents(){
  show_document_generation_options
    local doc_gen_choice
    read -p "Enter choice [ 1 - 2 ] " doc_gen_choice
    echo    # (optional) move to a new line
    case $doc_gen_choice in
          1)
            echo "Generating documents for task service"
            cd $HOME/$sesto_folder_name/envoy_server_task
            invoke -c devops docs.docs
            echo "Generated documents for task service"
            sleep 1
            pause
          ;;
          2)
            echo "Generating documents for ensemble service"
            cd $HOME/$sesto_folder_name/envoy_server_ensemble
            invoke -c devops docs.docs
            echo "Generated documents for ensemble service"
            sleep 1
            pause
          ;;
          3)
            echo "Generating documents for manager service"
            cd $HOME/$sesto_folder_name/envoy_server_manager
            invoke -c devops docs.docs
            echo "Generated documents for manager service"
            sleep 1
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
}

show_log_checking_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - L O G - C H E C K I N G - O P T I O N S \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Check logs for task service ${STD}"
    echo -e "2. ${YLW} Check logs for ensemble services ${STD}"
    echo -e "3. ${YLW} Check logs for manager services ${STD}"
}

check_logs(){
  show_log_checking_options
    local check_log_choice
    read -p "Enter choice [ 1 - 4 ] " check_log_choice
    echo    # (optional) move to a new line
    case $check_log_choice in
          1)
            echo "Displaying logs for task service"
            tail `/bin/ls -1td $HOME/$sesto_folder_name/envoy_server_task/task.log.*| /usr/bin/head -n1`
            sleep 1
            pause
          ;;
          2)
            echo "Displaying logs for ensemble service"
            tail `/bin/ls -1td $HOME/$sesto_folder_name/envoy_server_ensemble/ensemble.log.*| /usr/bin/head -n1`
            sleep 1
            pause
          ;;
          3)
            echo "Displaying logs for manager service"
            tail `/bin/ls -1td $HOME/$sesto_folder_name/envoy_server_manager/manager.log.*| /usr/bin/head -n1`
            sleep 1
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
}

show_port_check_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - P O R T - C H E C K I N G - O P T I O N S \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Check ports for task service ${STD}"
    echo -e "2. ${YLW} Check ports for ensemble services ${STD}"
    echo -e "3. ${YLW} Check ports for manager services ${STD}"
}
check_ports()
{
  show_port_check_options
    local check_port_choice
    read -p "Enter choice [ 1 - 4 ] " check_port_choice
    echo    # (optional) move to a new line
    case $check_port_choice in
          1)
            echo "Checking port status for task service"
            nc -z localhost 20002 && echo "IN USE" || echo "FREE"
            sleep 1
            pause
          ;;
          2)
            echo "Checking port status for ensemble service"
            nc -z localhost 20003 && echo "IN USE" || echo "FREE"
            sleep 1
            pause
          ;;
          3)
            echo "Checking port status for manager service"
            nc -z localhost 20005 && echo "IN USE" || echo "FREE"
            sleep 1
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
}


# function to display menus
show_menus() {
    echo "Refreshing..."
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m M I C R O - S E R V I C E - M E N U \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${GRN} Start Application Servers ${STD}"
    echo -e "2. ${GRN} Stop Application Servers ${STD}"
    echo -e "3. ${GRN} Start Application Servers - Production version ${STD}"
    echo -e "4. ${GRN} Stop Application Servers - Production version ${STD}"
    echo -e "5. ${GRN} Restart Individual Application Server ${STD}"
    echo -e "6. ${GRN} Check running application servers ports${STD}"
    echo -e "7. ${GRN} Upload data to database ${STD}"
    echo -e "8. ${GRN} Setup environment for all applications ${STD}"
    echo -e "9. ${GRN} Run unit tests ${STD}"
    echo -e "10. ${GRN} Generate documents for services ${STD}"
    echo -e "11. ${GRN} Check logs for running services ${STD}"
    echo -e "12. ${GRN} Exit ${STD}"
}

# read input from the keyboard and take a action
read_options(){
    local choice
    read -p "Enter choice [ 1 - 9 ] " choice
    case $choice in
        1) start ;;
        2) stop ;;
        3) start_production ;;
        4) stop_production ;;
        5) restart ;;
        6) check_ports ;;
        7) database_update ;;
        8) setup_environment ;;
        9) run_unit_tests ;;
        10) generate_documents ;;
        11) check_logs ;;
        12) exit 0;;
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

