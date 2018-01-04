module Tree (Tree, Direction(L, R), Node(Entity, Question),
  newTree, get, set, move, reset)
where

data Direction = L | R deriving (Show, Enum)

-- Breadcrumb tree structure adapted from Learn You a Haskell
data Crumb = LeftCrumb String Node
             | RightCrumb String Node deriving (Read, Show)

type Breadcrumbs = [Crumb]

data Tree = Tree Node Breadcrumbs deriving (Read, Show)

data Node = Entity String
          | Question String Node Node deriving (Read, Show)

newTree :: Node -> Tree
newTree n = Tree n []

move :: Tree -> Direction -> Tree
move (Tree node bs) direction = case node of
  Entity e -> Tree node bs
  Question q l r -> case direction of
    L -> Tree l ((LeftCrumb q r):bs)
    R -> Tree r ((RightCrumb q l):bs)

set :: Tree -> Node -> Tree
set (Tree _ bs) newNode = Tree newNode bs

get :: Tree -> Node
get (Tree node _) = node

reset :: Tree -> Tree
reset (Tree node ((LeftCrumb x r):bs)) = reset (Tree (Question x node r) bs)
reset (Tree node ((RightCrumb x l):bs)) = reset (Tree (Question x l node) bs)
reset (Tree node []) = Tree node []
