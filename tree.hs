module Tree (Tree, Dir(L, R), Node(Entity, Question),
  newTree, get, set, move, reset)
where

data Dir = L | R deriving (Show, Enum)

type Children = (Node, Node)
type Parent = Maybe (Node, Dir)

data Node = Entity String Parent
          | Question String Children Parent deriving (Show)

newtype Tree = Tree (Node) deriving (Show)

newTree :: Node -> Tree
newTree n = Tree n

get :: Tree -> Node
get (Tree n) = n

set :: Tree -> Node -> Tree
set (Tree (Entity e p)) n = let
  newParent = setParentBranch p newCurrent
  newCurrent = (Entity e newParent)
  in (Tree newCurrent)
set (Tree (Question q (l, r) p)) n = let
  newParent = setParentBranch p newCurrent
  newCurrent = (Question q (l, r) newParent)
  in (Tree newCurrent)

setParentBranch :: Parent -> Node -> Parent
setParentBranch p n = case p of
  Nothing -> Nothing
  Just (parent, d) -> Just ((setQuestionBranch parent d n), d)

setQuestionBranch :: Node -> Dir -> Node -> Node
setQuestionBranch (Question q (l, r) p) d n = case d of
      L -> (Question q (n, r) p)
      R -> (Question q (l, n) p)
setQuestionBranch _ _ _ = error ("ERROR: Tree.setQuestionBranch must be a question to set branch")

move :: Tree -> Dir -> Tree
move (Tree (Question _ (l, r) _)) d = case d of
  L -> (Tree l)
  R -> (Tree r)
move _ _ = error ("ERROR: Tree.move must be a question to move")

reset :: Tree -> Tree
reset (Tree (Entity e p)) = case p of
  Nothing -> (Tree (Entity e p))
  Just (parent, d) -> reset (Tree parent)
reset (Tree (Question q (l, r) p)) = case p of
  Nothing -> (Tree (Question q (l, r) p))
  Just (parent, d) -> reset (Tree parent)
