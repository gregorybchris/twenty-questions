module Main where

import System.IO
import Initializer
import Game
import Tree

main :: IO ()
main = do
  putStrLn "Welcome to 20 Questions"
  putStrLn "Please think of something. Press enter when ready..."
  getLine
  Game.makeGuesses Initializer.animals Play
