module TList (runTaskManager) where

import Test.HUnit
import Task (Task (..), TaskList)
import PreF

menu :: TaskList -> IO TaskList
menu taskList = do
  putStrLn "What do you like to do? add, edit, remove, view, sort, priority, count, quit: "
  command <- getLine
  case command of
    "add" -> do
      taskList' <- addTask taskList
      menu taskList'
    "edit" -> do
      -- unimplemented..
    "remove" -> do
      -- unimplemented..
    "view" -> do
      -- unimplemented..
    "sort" -> do
      -- unimplemented..
    "priority" -> do
      -- unimplemented..
    "count" -> do
      -- unimplemented..
    "quit" -> return taskList
    _ -> do
      putStrLn "Invalid, please try again"
      menu taskList

-- Function responsible for adding a task
addTask :: TaskList -> IO TaskList
addTask taskList = do
  putStrLn "what is the task name:"
  name <- getLine
  putStrLn "description:"
  description <- getLine
  putStrLn "Priority (1-10) , 1 not importanst, 10 very important:"
  priority <- getLine
  putStrLn "what is the due date (MM/DD/YYYY):"
  dueDate <- getLine
  let task = Task name description (read priority) dueDate
  return (task : taskList)

  -- I tried to define test cases for this function but it seems confusing.


-- unimplmneted modifying function. To edit any existed task. 
editT :: TaskList -> IO TaskList
editT = undefined

-- unimplmneted removing function. To removve any existed task. 
removeT :: TaskList -> IO TaskList
removeT = undefined


-- unimplmneted helper removing by name function.
nameRemove :: String -> TaskList -> TaskList
nameRemove = undefined

--Possible test cases
testNameRemove :: Test
testNameRemove =
  "nameRemove" ~:
    TestList [
      nameRemove [] "project" ~?= [],
      nameRemove [
        Task "homework" "any" 4 "03/03/2023",
        Task "garbage" "out" 8 "03/04/2023",
        Task "project" "test" 2 "03/28/2023"
      ] "garbage" ~?= [
        Task "homework" "any" 4 "03/03/2023",
        Task "project" "test" 2 "03/28/2023"
      ]
    ]

-- unimplemented helper function to search for a task byu name
nameSearch :: String -> TaskList -> Maybe Task
nameSearch = undefined

testNameSearch :: Test
testNameSearch =
  "nameSearch" ~:
    TestList [
      nameSearch [] "soccer" ~?= Nothing,
      nameSearch [
        Task "homework" "any" 4 "03/03/2023",
        Task "garbage" "out" 8 "03/04/2023",
        Task "project" "test" 2 "03/28/2023"
      ] "soccer match" ~?= Nothing,
      nameSearch [
        Task "homework" "any" 4 "03/03/2023",
        Task "garbage" "out" 8 "03/04/2023",
        Task "project" "test" 2 "03/28/2023"
      ] "project" ~?= Just (Task "project" "test" 2 "03/28/2023")
    ]


-- unimplmented siplay tasks function
displayTs :: TaskList -> IO ()
displayTs = undefined

-- simple function to start the loop menu for the user.
start :: IO TaskList
start = menu []
