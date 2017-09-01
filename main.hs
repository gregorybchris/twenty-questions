data QTree  =  Empty
            | Entity String
            | QuestionNode String QTree QTree deriving (Show)

main :: IO ()
main = do
    putStrLn "Welcome to 20 Questions"
    let entity1 = Entity "Dog"
    let entity2 = Entity "Cat"
    let entity3 = Entity "Roach"
    let entity4 = Entity "Moose"
    let question1 = QuestionNode "Does it have antlers?" entity4 entity1
    let question2 = QuestionNode "Does it have whiskers?" entity2 question1
    let question3 = QuestionNode "Is it bigger than a toaster?" question2 entity3
    putStrLn ("Tree: " ++ (show question3))
    putStrLn "Hello"
