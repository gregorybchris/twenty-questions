module Main where

import System.IO
import System.FilePath
import Initializer
import Serializer
import Game
import Tree

data InputType = ByInitializer
               | BySerializer

-- ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~
--                    Settings
--
inputMode = BySerializer :: InputType
inputFile = "animals.tq" :: FilePath
inputTree = Initializer.animals :: Tree
outputMode = True :: Bool
outputFile = "animals.tq" :: FilePath
--
--
-- ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~

main :: IO ()
main = do
  putStrLn "Welcome to 20 Questions"
  putStrLn "Please think of something. Press enter when ready..."
  getLine
  startGame

startGame :: IO ()
startGame = do
  case inputMode of
    ByInitializer -> do
      let tree = inputTree
      case outputMode of
        True -> do
          let outputSerializer = Serializer.newSerializer outputFile
          Game.playGame tree (Edit outputSerializer)
        False -> Game.playGame tree Play
    BySerializer -> do
      let inputSerializer = Serializer.newSerializer inputFile
      tree <- Serializer.deserialize inputSerializer
      case outputMode of
        True -> do
          let outputSerializer = Serializer.newSerializer outputFile
          Game.playGame tree (Edit outputSerializer)
        False -> Game.playGame tree Play
