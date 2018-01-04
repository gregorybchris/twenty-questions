module Serializer (Serializer, newSerializer, serialize, deserialize) where

import Tree
import System.FilePath

newtype STree = STree (SNode) deriving (Read, Show)

data SNode = Q String SNode SNode
           | E String deriving (Read, Show)

newtype Serializer = Serializer (FilePath)

newSerializer :: String -> Serializer
newSerializer path = Serializer path

serialize :: Serializer -> Tree -> IO ()
serialize (Serializer file) tree = do
  writeFile file $ show $ treeToSTree tree

deserialize :: Serializer -> IO Tree
deserialize (Serializer file) = do
  fileText <- readFile file
  return $ sTreeToTree $ read fileText

sTreeToTree :: STree -> Tree
sTreeToTree (STree n) = Tree.newTree $ sNodeToNode n Nothing

sNodeToNode :: SNode -> Parent -> Node
sNodeToNode n p = case n of
  Q q l r -> let
    leftChild = sNodeToNode l (Just (current, L))
    rightChild = sNodeToNode r (Just (current, R))
    current = Question q (leftChild, rightChild) p
    in current
  E e -> (Entity e p)

treeToSTree :: Tree -> STree
treeToSTree t = let
  n = Tree.get t
  in (STree (nodeToSNode n))

nodeToSNode :: Node -> SNode
nodeToSNode n = case n of
  Entity e p -> E e
  Question q (l, r) p -> Q q (nodeToSNode l) (nodeToSNode r)
