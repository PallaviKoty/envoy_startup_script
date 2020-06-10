#!/bin/bash
# A menu driven shell script sample template

RED='\033[0;41;30m'
STD='\033[0;0;39m'
GRN='\e[92m'
BLU='\e[104m'
YLW='\e[33m'

task_port=20002
ensemble_port=20003
manager_port=20005
payload_port=40001

sesto_folder_name=sesto_mission_app
task_log_file=$HOME/$sesto_folder_name/envoy_server_task/docs/task.log
manager_log_file=$HOME/$sesto_folder_name/envoy_server_manager/docs/manager.log
ensemble_log_file=$HOME/$sesto_folder_name/envoy_server_ensemble/docs/ensemble.log
payload_log_file=$HOME/$sesto_folder_name/envoy_amr_payload/docs/payload.log

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
    echo -e "4. ${YLW} Start payload service ${STD}"
    echo -e "5. ${YLW} Start all services ${STD}"
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

start_payload_service(){
  echo "Starting payload service..."
  python3 $HOME/$sesto_folder_name/envoy_amr_payload/main.py >> $payload_log_file.$(date "+%Y.%m.%d-%H.%M.%S") 2>&1 &
  sleep 1
  echo "Started payload service."
}

start_all_services(){
  echo "Starting all services..."
  start_task_service
  start_ensemble_service
  start_manager_service
  start_payload_service
  echo "Started all service."
}

start(){
    show_start_options
    local start_choice
    read -p "Enter choice [ 1 - 5 ] " start_choice
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
            start_payload_service
            pause
          ;;
          5)
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
    echo -e "4. ${YLW} Stop payload services ${STD}"
    echo -e "5. ${YLW} Stop all services ${STD}"
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

stop_payload_service(){
  echo "Stopping payload service..."
  ps -ef | grep "envoy_amr_payload/main.py" | grep -v grep | awk '{print $2}' | xargs kill
  sleep 1
  echo "Stopped payload service."
}

stop(){
    show_stop_options
    local stop_choice
    read -p "Enter choice [ 1 - 5 ] " stop_choice
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
            stop_payload_service
            pause
          ;;
          5)
            kill_all
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

kill_all(){
  read -p "Are you sure to stop all services?[Y/y] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo "Stopping all services..."
      stop_task_service
      stop_ensemble_service
      stop_manager_service
      stop_payload_service
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
    echo -e "4. ${YLW} Restart payload services ${STD}"
    echo -e "5. ${YLW} Restart all services ${STD}"
}

restart(){
  show_restart_options
    local restart_choice
    read -p "Enter choice [ 1 - 5 ] " restart_choice
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
            stop_payload_service
            start_payload_service
            sleep 1
            pause
          ;;
          5)
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
  read -p "All the records in this collection will be removed before adding the new records. Are you sure to remove the records?[Y/y] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    read -p "Enter the name of the python file to update data to the database: " path
    echo
    mongo localhost:27017/envoydb $HOME/$sesto_folder_name/db_scripts/$path
    echo "Updated DB"
  fi
  pause
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
  inv -c devops environment.setup-mongodb
  inv -c devops environment.setup
  echo "Done setting up environment for ensemble"
}

setup_manager_environment(){
  echo "Setting up environment for manager"
  cd $HOME/$sesto_folder_name/envoy_server_manager
  inv -c devops environment.setup
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
    echo -e "3. ${YLW} Run unit tests for payload services ${STD}"
}

run_unit_tests(){
  show_unit_test_options
    local unit_test_choice
    read -p "Enter choice [ 1 - 4 ] " unit_test_choice
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
          4)
            echo "Running unittest for payload service"
            cd $HOME/$sesto_folder_name/envoy_amr_payload
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
    echo -e "4. ${YLW} Generate documents for payload services ${STD}"
}

generate_documents(){
  show_document_generation_options
    local doc_gen_choice
    read -p "Enter choice [ 1 - 4 ] " doc_gen_choice
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
          4)
            echo "Generating documents for payload service"
            cd $HOME/$sesto_folder_name/envoy_amr_payload
            invoke -c devops docs.docs
            echo "Generated documents for payload service"
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
    echo -e "3. ${YLW} Check logs for payload services ${STD}"
}

check_logs(){
  show_log_checking_options
    local check_log_choice
    read -p "Enter choice [ 1 - 4 ] " check_log_choice
    echo    # (optional) move to a new line
    case $check_log_choice in
          1)
            echo "Displaying logs for task service"
            tail `/bin/ls -1td $HOME/$sesto_folder_name/envoy_server_task/docs/task.log.*| /usr/bin/head -n1`
            sleep 1
            pause
          ;;
          2)
            echo "Displaying logs for ensemble service"
            tail `/bin/ls -1td $HOME/$sesto_folder_name/envoy_server_ensemble/docs/ensemble.log.*| /usr/bin/head -n1`
            sleep 1
            pause
          ;;
          3)
            echo "Displaying logs for manager service"
            tail `/bin/ls -1td $HOME/$sesto_folder_name/envoy_server_manager/docs/manager.log.*| /usr/bin/head -n1`
            sleep 1
            pause
          ;;
          4)
            echo "Displaying logs for payload service"
            tail `/bin/ls -1td $HOME/$sesto_folder_name/envoy_amr_payload/docs/payload.log.*| /usr/bin/head -n1`
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
    echo -e "4. ${YLW} Check ports for payload services ${STD}"
    echo -e "5. ${YLW} Check ports for all services ${STD}"
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
            nc -z localhost $task_port && echo "IN USE" || echo "FREE"
            sleep 1
            pause
          ;;
          2)
            echo "Checking port status for ensemble service"
            nc -z localhost $ensemble_port && echo "IN USE" || echo "FREE"
            sleep 1
            pause
          ;;
          3)
            echo "Checking port status for manager service"
            nc -z localhost $manager_port && echo "IN USE" || echo "FREE"
            sleep 1
            pause
          ;;
          4)
            echo "Checking port status for payload service"
            nc -z localhost $payload_port && echo "IN USE" || echo "FREE"
            sleep 1
            pause
          ;;
          5)
            echo "Checking port status for all services"
            nc -z localhost $task_port && echo "Task Port: IN USE" || echo "Task Port: FREE"
            sleep 1
            nc -z localhost $ensemble_port && echo "Ensemble Port: IN USE" || echo "Ensemble Port: FREE"
            sleep 1
            nc -z localhost $manager_port && echo "Manager Port: IN USE" || echo "Manager Port: FREE"
            sleep 1
            nc -z localhost $payload_port && echo "Payload Port: IN USE" || echo "Payload Port: FREE"
            sleep 1
            pause
          ;;
          *)
            echo "Sorry, wrong service choice"
          ;;
        esac
}

install_gensiys()
{
  local local_repo_name
  local local_branch_name
  read -p "Enter the name of the local repository: " local_repo_name
  echo    # (optional) move to a new line
  read -p "Enter the name of the branch: " local_branch_name
  echo "Installing genisys from local repository"
  pip install git+https://github.com/$local_repo_name/genisys.git@$local_branch_name\#egg:genisys
  echo "Done installing"
  pause
}

uninstall_genisys(){
  read -p "Are you sure to uninstall genisys?[Y/y] " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    pip uninstall -y genisys
    sleep 1
  fi
  pause
}

setup_venv(){
  echo "Setting up virtual environment"
  cd $HOME/$sesto_folder_name
#  virtualenv -p /usr/bin/python3 sesto_envoy_venv
  source sesto_envoy_venv/bin/activate
  echo "Done setting up virtual environment"
}

delete_all_collections_from_db(){
  read -p "Are you sure to delete data from envoy DB?[Y/y] " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    mongo localhost:27017/envoydb $HOME/$sesto_folder_name/db_scripts/delete_all_collections.js
    echo "Deleted all collections"
  fi
  pause
}

show_git_pull_options(){
  echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e " \e[40;38;5;82m\e[30;48;5;82m C H O S E - G I T - P U L L - O P T I O N S \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${YLW} Pull codes for task service ${STD}"
    echo -e "2. ${YLW} Pull codes for ensemble services ${STD}"
    echo -e "3. ${YLW} Pull codes for manager services ${STD}"
    echo -e "4. ${YLW} Pull codes for payload services ${STD}"
    echo -e "5. ${YLW} Pull codes for all services ${STD}"
}

git_pull()
{
  show_git_pull_options
    local pull_choice
    read -p "Enter choice [ 1 - 4 ] " pull_choice
    echo    # (optional) move to a new line
    case $pull_choice in
          1)
            echo "Pulling codes for task service"
            cd $HOME/$sesto_folder_name/envoy_server_task
            git pull
            sleep 1
            pause
          ;;
          2)
            echo "Pulling codes for ensemble service"
            cd $HOME/$sesto_folder_name/envoy_server_ensemble
            git pull
            sleep 1
            pause
          ;;
          3)
            echo "Pulling codes for manager service"
            cd $HOME/$sesto_folder_name/envoy_server_manager
            git pull
            sleep 1
            pause
          ;;
          4)
            echo "Pulling codes for payload service"
            cd $HOME/$sesto_folder_name/envoy_amr_payload
            git pull
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
    echo -e " \e[40;38;5;82m\e[30;48;5;82m S T A R T U P - S C R I P T - M E N U \e[0m "
    echo "~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1. ${GRN}  Start Application Servers ${STD}"
    echo -e "2. ${GRN}  Stop Application Servers ${STD}"
    echo -e "3. ${GRN}  Start Application Servers - Production version ${STD}"
    echo -e "4. ${GRN}  Stop Application Servers - Production version ${STD}"
    echo -e "5. ${GRN}  Restart Individual Application Server ${STD}"
    echo -e "6. ${GRN}  Check running application servers ports${STD}"
    echo -e "7. ${GRN}  Upload data to database ${STD}"
    echo -e "8. ${GRN}  Setup environment for all applications ${STD}"
    echo -e "9. ${GRN}  Run unit tests ${STD}"
    echo -e "10. ${GRN} Generate documents for services ${STD}"
    echo -e "11. ${GRN} Check logs for running services ${STD}"
    echo -e "12. ${GRN} Install genisys from local repository ${STD}"
    echo -e "13. ${GRN} Uninstall genisys ${STD}"
    echo -e "14. ${GRN} Setup virtual environment ${STD}"
    echo -e "15. ${GRN} Delete all collections from the database ${STD}"
    echo -e "16. ${GRN} Pull the codes for individual applications from GIT ${STD}"
    echo -e "17. ${GRN} Exit ${STD}"
}

# read input from the keyboard and take a action
read_options(){
    local choice
    read -p "Enter choice [ 1 - 17 ] " choice
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
        12) install_gensiys;;
        13) uninstall_genisys ;;
        14) setup_venv ;;
        15) delete_all_collections_from_db ;;
        16) git_pull;;
        17) exit 0;;
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

