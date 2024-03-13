#!/bin/bash

input_path=$1

# match the extension of the file
EXTENSION=$(echo $input_path | sed 's/.*\.\(.*\)/\1/g')

# get input path folder
INPUT_FOLDER=$(dirname $input_path)

# loop through all the lines in the file

HEADER=""

CLASSES_STARTED=0

CURRENT_CLASS_NAME=""
CURRENT_CLASS_CONTENT=""

cat $input_path | while read line
do
    # using preg -i check if the line is a class
    IS_CLASS=$(echo $line | grep -i "class")

    # if the line is a class, set CLASSES_STARTED to 1
    if [ -n "$IS_CLASS" ]; then
        CLASSES_STARTED=1

        # if the current class name is not empty, write the content to a file
        if [ -n "$CURRENT_CLASS_NAME" ]; then

            OUTPUT_PATH="$INPUT_FOLDER/$CURRENT_CLASS_NAME.$EXTENSION"
            OUTPUT_CONTENT="$HEADER\n$CURRENT_CLASS_CONTENT"

            # if not file already exists, create it
            if [ ! -f $OUTPUT_PATH ]; then
                echo -e $OUTPUT_CONTENT > $OUTPUT_PATH
            fi

            CURRENT_CLASS_CONTENT=""
        fi

        CURRENT_CLASS_NAME="$line"
        # replace the word class with ""
        CURRENT_CLASS_NAME=$(echo $CURRENT_CLASS_NAME | sed 's/class//g')
        # remove everything after :
        CURRENT_CLASS_NAME=$(echo $CURRENT_CLASS_NAME | sed 's/:.*//g')
        # remove everything after {
        CURRENT_CLASS_NAME=$(echo $CURRENT_CLASS_NAME | sed 's/{.*//g')
        # remove everything after (
        CURRENT_CLASS_NAME=$(echo $CURRENT_CLASS_NAME | sed 's/(.*//g')
        # trim using myVar=`echo $myVar | sed 's/ *$//g'`
        CURRENT_CLASS_NAME=$(echo $CURRENT_CLASS_NAME | sed 's/ *$//g')
        # remove everything after " "
        CURRENT_CLASS_NAME=$(echo $CURRENT_CLASS_NAME | sed 's/ .*//g')
        echo "$CURRENT_CLASS_NAME"
    fi

    # if not CLASSES_STARTED, add the line to the header
    if [ $CLASSES_STARTED -eq 0 ]; then
        HEADER="$HEADER\n$line"
    else
        # Append the line to the current class content
        CURRENT_CLASS_CONTENT="$CURRENT_CLASS_CONTENT\n$line"
    fi


done