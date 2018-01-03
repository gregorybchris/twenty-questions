module Serializer (serialize, deserialize) where

import Tree

serialize :: Tree -> String -> IO ()
serialize tree file = do return ()

deserialize :: String -> IO Tree
deserialize file = error ("Not Implemented")
