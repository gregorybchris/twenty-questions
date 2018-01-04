module Game (makeGuesses, Mode(Play, Edit)) where

import Tree
import System.IO
import Serializer
import Data.Text as Text
import Data.Char as Char

data Response = Yes | No
data Mode = Play
          | Edit Serializer

makeGuesses :: Tree -> Mode -> IO ()
makeGuesses tree mode = do
  case (Tree.get tree) of
    Question question _ _ -> do
      response <- getResponse question
      let direction = getDirection response
      let movedTree = Tree.move tree direction
      makeGuesses movedTree mode
    Entity entity parent -> do
      response <- getResponse $ "Were you thinking of " ++ entity ++ "?"
      case response of
        Yes -> putStrLn "Nice"
        No -> do
          putStrLn "Congrats you stumped me!"
          case mode of
            Play -> return ()
            Edit serializer -> do
              putStrLn "What were you thinking of?"
              newEntity <- getLine
              putStrLn $ "Enter a question that is true for " ++ newEntity ++ ", but not for " ++ entity
              newQuestion <- getLine
              let updatedTree = Tree.reset $ updateTree tree entity parent newEntity newQuestion
              Serializer.serialize serializer updatedTree
          putStrLn "GAME OVER"
          playAgain <- getResponse "Play again?"
          case playAgain of
            No -> return ()
            Yes -> makeGuesses (Tree.reset tree) mode

updateTree :: Tree -> String -> Parent -> String -> String -> Tree
updateTree oldTree oldEntity oldParent newEntity newQuestion = let
  newParent = case oldParent of
    Nothing -> Nothing
    Just (oldParentNode, d) -> let
      Question q (l, r) gp = oldParentNode
      in case d of
        R -> Just ((Question q (l, newQuestionNode) gp), d)
        L -> Just ((Question q (newQuestionNode, r) gp), d)
  newEntityNode = Entity newEntity (Just (newQuestionNode, Tree.L))
  oldEntityNode = Entity oldEntity (Just (newQuestionNode, Tree.R))
  newQuestionNode = Question newQuestion (newEntityNode, oldEntityNode) newParent
  updatedTree = Tree.newTree newQuestionNode
  in updatedTree

getDirection :: Response -> Tree.Dir
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
