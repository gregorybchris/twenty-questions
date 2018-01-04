module Initializer (animals) where

import Tree

animals :: Tree
animals = let
  entity1 = Entity "Dog"
  entity2 = Entity "Cat"
  entity3 = Entity "Roach"
  entity4 = Entity "Moose"
  question1 = Question "Does it have antlers?" entity4 entity1
  question2 = Question "Does it have whiskers?" entity2 question1
  question3 = Question "Is it bigger than a toaster?" question2 entity3
  t = Tree.newTree question3
  in t
