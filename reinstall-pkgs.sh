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
