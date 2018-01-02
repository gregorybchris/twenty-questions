module Main where

import System.IO
import Initializer
import Game
import Tree

main :: IO ()
main = do
  putStrLn "Welcome to 20 Questions"
  putStrLn "Please think of something. Press enter when ready..."
  v <- getLine
  let
    tree = Initializer.animals
    node = Tree.get tree
    firstAnimal = case node of
      Question q (l, r) p -> q
      Entity e p -> e
  putStrLn firstAnimal
