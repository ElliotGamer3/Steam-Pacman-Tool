#!/bin/ bash

#check if running as sudo and fail if not
if [ "$EUID" -ne 0 ]; then
    echo "Must be run as root"
    exit
fi

#check if an --all option was passed in
if [ "$1" = "--test" ]; then
    #run the test scripts in the test directory and wait for them to finish
    echo "Running test scripts..."
    for file in $(ls ./test);do
        echo "Running $file..."
        bash ./test/$file
        pids+=($!)
    done
    for pid in ${pids[@]};do
        wait $pid
    done
    echo "Test scripts finished."
    #exit the script but not the terminal
    exit
fi

#check if a --init option was passed in and if so, run the init.sh script
if [ "$1" = "--init" ]; then
    echo "Running init script..."
    bash ./init.sh
    echo "Init script finished."
fi

#check if an --all option was passed in
if ["$1" = "--all"]; then
    # run all of the scripts in the pkg directory on a seprate fork
    for i in $( ls ./pkg ); do
        # run the script in the background
        bash ./pkg/$i&
        # save the pid of the script toi an array
        pids+=($!)
    done
    # loop through the pids array and wait for each process to finish
    for pid in ${pids[@]}; do
        wait $pid
    done
    #print a message when all of the scripts have finished
    echo "All scripts have finished"
fi

#check if the --list option was passed in
if [ "$1" = "--list" ]; then
    #print a list of the scripts in the pkg directory
    echo "Scripts in the pkg directory:"
    for i in $( ls ./pkg ); do
        echo $i
    done
fi

#check if the --these option was passed in
#if so then run the scripts that were passed in
if [ "$1" = "--these" ]; then
    #loop through the arguments passed in
    for i in "$@"; do
        #check if the argument is a script in the pkg directory
        if [ -f ./pkg/$i ]; then
            #run the script in the background
            bash ./pkg/$i&
            #save the pid of the script to an array
            pids+=($!)
        fi
    done
    #loop through the pids array and wait for each process to finish
    for pid in ${pids[@]}; do
        wait $pid
    done
    #print a message when all of the scripts have finished
    echo "All scripts have finished"
fi

#check if a --help option was passed in and if so, print the help message
if [ "$1" = "--help" ]; then
    echo "Usage: ./reinstall-pkgs.sh [OPTION]"
    echo "Reinstall packages on a steamOS system."
    echo " "
    echo "Options:"
    echo "  --all      install all packages in the pkg directory"
    echo "  --list     list all packages in the pkg directory"
    echo "  --these    install the packages from the pkg directory specified after the --these option"
    echo "  --init     run the init script after an update to the system"
    echo "  --test     run the test scripts in the test directory"
    echo "  --help     display this help message"
    echo " "
    echo "Report bugs to <elliotgamer3@gmail.com>"
    echo "Repository: <https://github.com/ElliotImhoff/Steam-Pacman-Tool.git>"
fi