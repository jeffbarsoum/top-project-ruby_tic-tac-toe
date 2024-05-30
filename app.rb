# Add load paths here:
$LOAD_PATH.unshift('save')
$LOAD_PATH.unshift('module')
$LOAD_PATH.unshift('class')
$LOAD_PATH.unshift('state')

# load required scripts here:
require "tic_tac_toe"

# launch application:
TicTacToe.new
