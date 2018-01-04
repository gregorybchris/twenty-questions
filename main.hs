module Main where

import System.IO
import System.FilePath
import Initializer
import Serializer
import Game

data InputType = ByInitializer
               | BySerializer

-- ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~
--                    Settings
--
inputMode = ByInitializer :: InputType
inputFile = "animals.tq" :: FilePath
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
      let tree = Initializer.animals
      case outputMode of
        True -> do
          let outputSerializer = Serializer.newSerializer outputFile
          Game.makeGuesses tree (Edit outputSerializer)
        False -> Game.makeGuesses tree Play
    BySerializer -> do
      let inputSerializer = Serializer.newSerializer inputFile
      tree <- Serializer.deserialize inputSerializer
      case outputMode of
        True -> do
          let outputSerializer = Serializer.newSerializer outputFile
          Game.makeGuesses tree (Edit outputSerializer)
        False -> Game.makeGuesses tree Play
