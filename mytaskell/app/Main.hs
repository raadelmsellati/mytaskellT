module Main (main) where

import TList (start)
import Task

main :: IO ()
main = do
  putStrLn "Welcome to MyTaskell! A task manager by Haskell"
  taskList <- start
