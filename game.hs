module Game (makeGuesses, Mode(Play, Edit)) where

import Tree
import System.IO
import Data.Text as Text
import Data.Char as Char

data Response = Yes | No
data Mode = Play | Edit

makeGuesses :: Tree -> Mode -> IO ()
makeGuesses t m = do
  let node = Tree.get t
  case node of
    (Question q (l, r) p) -> do
      response <- getResponse q
      let direction = getDirection response
      let newTree = Tree.move t direction
      makeGuesses newTree m
    (Entity e p) -> do
      response <- getResponse $ "Were you thinking of " ++ e ++ "?"
      case response of
        Yes -> do
          putStrLn "Nice"
        No -> do
          putStrLn "Congrats you stumped me!"
          case m of
            Play -> do return ()
            Edit -> do
              putStrLn "What were you thinking of?"
              newEntity <- getLine
              putStrLn $ "Enter a question that is true for " ++ newEntity ++ ", but not for " ++ e
              newQuestion <- getLine
              return ()
              -- Update tree and serialize
          putStrLn "GAME OVER"
          playAgain <- getResponse "Play again?"
          case playAgain of
            No -> do return ()
            Yes -> do
              putStrLn "Please think of something. Press enter when ready..."
              getLine
              let resetTree = Tree.reset t
              makeGuesses resetTree m

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
    "n" -> do return No
    "no" -> do return No
    "y" -> do return Yes
    "yes" -> do return Yes
    _ -> do
      r <- getResponse $ "Invalid input. Try again (y/n)"
      return r

getArticle :: String -> String
getArticle (x:xs) = if (elem (Char.toLower x) "aeiou") then "an" else "a"
