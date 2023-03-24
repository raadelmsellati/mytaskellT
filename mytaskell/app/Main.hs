module Main (main) where

import Test.HUnit
import TList
import Task
import PreF

main :: IO ()
main = do
  putStrLn "Welcome to MyTaskell! A task manager by Haskell"
  taskList <- start
  _ <- runTestTT $ TestList [testNameRemove, testNameSearch, testprioritySort, testpriorityHigh, testpriorityFilter]
  return ()
