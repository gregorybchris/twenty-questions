# Twenty Questions

## About

I have grown to really love Haskell since I first heard about it in my Programming Languages (COMP 105) at Tufts. There is something about the type system and syntax that really appeal to me. While Java and Python are easy to use for large-scale applications the functional style feels somewhat safer and is more interesting after years of the same object-oriented programming.

This is actually my second Twenty Questions program. The first I made when learning about trees and recursion in my high school Data Structures class. I called it "Guesser" and it was a Java Swing implementation that allowed the user input new possibilities and then serialized the updated decision tree. It was one of my first programs with persistence.

![Master](/Guesser.jpg?raw=true "Guesser")

Before now I was shaky on Haskell IO, so I decided to dive right in with a project I knew would introduce me to many different IO problems.

## How to Run

- Adjust input and output settings in `main.hs` if desired
- Ensure you have a Haskell compiler installed `ghc --version`
- Compile and run with:

```Haskell
  ghc main.hs
  ./main
```

## Next Steps

- Enhance readability of prompts
- Clean input text by articles, capitalization, punctuation, etc.
- Add documentation
- Add unit tests
- Port project to the web with a Haskell web framework
- Restructure tree to maximize information gain at each question
