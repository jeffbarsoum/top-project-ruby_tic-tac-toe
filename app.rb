# Add load paths here:
$LOAD_PATH.unshift('lib/module')
$LOAD_PATH.unshift('lib/class')
$LOAD_PATH.unshift('save')

# load required scripts here:
require "loader"

# launch application:
loader = Loader.new
game = loader.load_game "tic_tac_toe"
