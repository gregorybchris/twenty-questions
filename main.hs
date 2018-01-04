module Main where

import System.IO
import System.FilePath
import Initializer
import Serializer
import Game
import Tree

main :: IO ()
main = do
  putStrLn "Welcome to 20 Questions"
  putStrLn "Please think of something. Press enter when ready..."
  getLine
  let animals = Initializer.animals
  -- animals <- Serializer.deserialize serializer
  let serializer = Serializer.newSerializer "animals.tq"
  Game.makeGuesses animals (Edit serializer)
