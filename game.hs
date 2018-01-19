module Game (playGame, Mode(Play, Edit)) where

import Tree
import System.IO
import Serializer
import Data.Text as Text
import Data.Char as Char

data Response = Yes | No
data Mode = Play
          | Edit Serializer

playGame :: Tree -> Mode -> IO ()
playGame tree mode = makeGuesses tree mode 1

makeGuesses :: Tree -> Mode -> Int -> IO ()
makeGuesses tree mode guesses = do
  case (Tree.get tree) of
    Question question _ _ -> do
      putStr $ "Question " ++ (show guesses) ++ ": "
      response <- getResponse question
      let direction = getDirection response
      let movedTree = Tree.move tree direction
      makeGuesses movedTree mode (guesses + 1)
    Entity entity -> do
      response <- getResponse $ "Were you thinking of " ++ entity ++ "?"
      case response of
        Yes -> do
          putStrLn "Nice"
          promptPlayAgain (Tree.reset tree) mode
        No -> do
          putStrLn "Congrats! you stumped me."
          case mode of
            Play -> promptPlayAgain tree mode
            Edit serializer -> do
              putStrLn "What were you thinking of?"
              newEntity <- getLine
              putStrLn $ "Enter a question that is true for " ++ newEntity ++ ", but not for " ++ entity
              newQuestion <- getLine
              let updatedTree = Tree.reset $ updateTree tree entity newEntity newQuestion
              Serializer.serialize serializer updatedTree
              promptPlayAgain updatedTree mode

updateTree :: Tree -> String -> String -> String -> Tree
updateTree oldTree oldEntity newEntity newQuestion = let
  newEntityNode = Entity newEntity
  oldEntityNode = Entity oldEntity
  newQustionNode = Question newQuestion newEntityNode oldEntityNode
  updatedTree = Tree.set oldTree newQustionNode
  in updatedTree

promptPlayAgain :: Tree -> Mode -> IO ()
promptPlayAgain tree mode = do
  playAgain <- getResponse "Play again?"
  case playAgain of
    No -> return ()
    Yes -> playGame tree mode

getDirection :: Response -> Tree.Direction
getDirection r = case r of
  No -> Tree.R
  Yes -> Tree.L

getResponse :: String -> IO Response
getResponse prompt = do
  putStrLn prompt
  input <- getLine
  let lowerInput = Text.unpack $ Text.toLower $ Text.pack input
  case lowerInput of
    "n" -> return No
    "y" -> return Yes
    _ -> do
      r <- getResponse $ "Invalid input. Try again (y/n)"
      return r

-- getArticle :: String -> String
-- getArticle (x:xs) = if (elem (Char.toLower x) "aeiou") then "an" else "a"
