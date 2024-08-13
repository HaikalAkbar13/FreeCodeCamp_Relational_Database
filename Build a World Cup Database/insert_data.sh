#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")

# Command for insert values to TEAMS table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS
do
  if [[ $WINNER != 'winner' ]]
  then
    # check the values of WINNER
    NAME1_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # If not found
    if [[ -z $NAME1_ID ]]
    then
      # insert WINNER as name in Teams Table
      INSERT_NAME1_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_NAME1_RESULT = 'INSERT 0 1' ]]
      then
        echo Inserted to name, $WINNER
      fi
    fi

    # get new name1_id
    NAME1_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # check the values of OPPONENT
    NAME2_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # if not found
    if [[ -z $NAME2_ID ]]
    then
      # insert the data
      INSERT_NAME2_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_NAME2_RESULT = 'INSERT 0 1' ]]
      then
        echo Inserted to name, $OPPONENT
      fi
    fi

    # get new name2_id
    NAME2_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  fi
done

# Command for insert values to GAMES table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS
do
  if [[ $YEAR != 'year' ]]
  then
    # check the WINNER and OPPONENT id
    WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # Insert into the table
    INSERT_GAMES=$($PSQL"INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES($YEAR, $WIN_ID, $OPP_ID, $WIN_GOALS, $OPP_GOALS, '$ROUND')")
    if [[ $INSERT_GAMES = 'INSERT 0 1' ]]
    then
      echo Inserted. The winner between $WINNER and $OPPONENT on $ROUND in $YEAR is : $WINNER
    fi
  fi
done
