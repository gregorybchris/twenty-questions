module Serializer (Serializer, newSerializer, serialize, deserialize) where

import Tree
import System.FilePath

newtype Serializer = Serializer (FilePath)

newSerializer :: String -> Serializer
newSerializer path = Serializer path

serialize :: Serializer -> Tree -> IO ()
serialize (Serializer file) tree = do
  writeFile file $ map succ $ show tree

deserialize :: Serializer -> IO Tree
deserialize (Serializer file) = do
  fileText <- readFile file
  return $ read $ map pred fileText
