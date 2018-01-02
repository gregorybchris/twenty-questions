module Initializer (animals) where

import Tree

animals :: Tree
animals = let
  entity1 = Tree.Entity "Dog" (Just (question1, Tree.R))
  entity2 = Tree.Entity "Cat" (Just (question2, Tree.L))
  entity3 = Tree.Entity "Roach" (Just (question3, Tree.R))
  entity4 = Tree.Entity "Moose" (Just (question1, Tree.L))
  question1 = Tree.Question "Does it have antlers?" (entity4, entity1) (Just (question2, Tree.R))
  question2 = Tree.Question "Does it have whiskers?" (entity2, question1) (Just (question3, Tree.L))
  question3 = Tree.Question "Is it bigger than a toaster?" (question2, entity3) Nothing
  t = newTree question3
  in Tree.reset t
