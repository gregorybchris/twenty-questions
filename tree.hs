module Tree (Tree, Dir(L, R), Node(Entity, Question), Parent,
  newTree, get, newTreeWithParent, move, reset)
where

data Dir = L | R deriving (Show, Enum)

type Children = (Node, Node)
type Parent = Maybe (Node, Dir)

data Node = Entity String Parent
          | Question String Children Parent

newtype Tree = Tree (Node)

newTree :: Node -> Tree
newTree n = Tree n

get :: Tree -> Node
get (Tree n) = n

newTreeWithParent :: Node -> Parent -> Tree
newTreeWithParent n p = case n of
  Entity e _ -> Tree (Entity e p)
  Question q (l, r) _ -> Tree (Question q (l, r) p)

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
