module TList (start, testNameRemove, testNameSearch ) where

import Test.HUnit
import Task (Task (..), TaskList)
import PreF

menu :: TaskList -> IO TaskList
menu taskList = do
  putStrLn "------------------------------------------------------------"
  putStrLn "What do you like to do?"
  putStrLn "-add (Add a new task)"
  putStrLn "-edit (Edit an existed task)" 
  putStrLn "-remove (Remove an existed task)"
  putStrLn "-view (Display existed tasks)"
  putStrLn "-high (Get the the most important task 'recent added')"
  putStrLn "-sort (Sort tasks by priority Low To High)" 
  putStrLn "-priority (Filter tasks by priority)"
  putStrLn "-count (Get total number of existed tasks)"
  putStrLn "-mark (mark as finished)"
  putStrLn "-quit"
  command <- getLine
  case command of
    "add" -> do
      taskList' <- addTask taskList
      menu taskList'
    "edit" -> do
      taskList' <- editT taskList
      menu taskList'
    "remove" -> do
      taskList' <- removeT taskList
      menu taskList'
    "view" -> do
      displayTs taskList
      menu taskList
    "sort" -> do
      let sortedList = prioritySort taskList
      displayTs sortedList
      menu taskList
    "priority" -> do
      putStrLn "Enter a priority:"
      priorityStr <- getLine
      let priority = read priorityStr :: Int
          fList = priorityFilter priority taskList
      displayTs fList
      menu taskList
    "count" -> do
      let count = totalTask taskList
      putStrLn $ "Total Tasks you have: " ++ show count
      menu taskList
    "high" -> do
      let highest = priorityHigh taskList
      displayTs highest
      menu taskList
    "mark" -> do
      taskList' <- markCompleted taskList
      menu taskList'
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
  dDate <- getLine
  let task = Task name description (read priority) dDate False
  return (task : taskList)

  -- I tried to define test cases for this function but it seems confusing.


-- unimplmneted modifying function. To edit any existed task. 
editT :: TaskList -> IO TaskList
editT taskList = do
  putStrLn "Name of task you want to modify:"
  name <- getLine
  case nameSearch name taskList of
    Just task -> do 
      putStrLn "New name (Enter to keep the same name):"
      newName <- getLine
      let name' = if null newName then tName task else newName

      putStrLn "New description (Enter to keep the same description):"
      newDesc <- getLine
      let description' = if null newDesc then tDesc task else newDesc

      putStrLn "New priority (Enter to keep the same priority):"
      newPrio <- getLine
      let prio' = if null newPrio then tPrio task else read newPrio

      putStrLn "New Due Date (Enter to keep the same date):"
      newDate <- getLine
      let date' = if null newDate then dueDate task else newDate



      let task' = Task name' description' prio' date' False
      let taskList' = nameReplace name task' taskList
      putStrLn "The task was successfully edited"
      return taskList'
    Nothing -> do
      putStrLn "There is no such a task"
      return taskList

-- unimplmneted removing function. To removve any existed task. 
removeT :: TaskList -> IO TaskList
removeT taskList = do
  putStrLn "Name of the task you want to remove:"
  name <- getLine
  case nameSearch name taskList of
    Just task -> do
      let taskList' = nameRemove name taskList
      putStrLn "The task was successfully removed"
      return taskList'
    Nothing -> do
      putStrLn "Task not found"
      return taskList


-- unimplmneted helper removing by name function.
nameRemove :: String -> TaskList -> TaskList
nameRemove name taskList = filter (\t -> tName t /= name) taskList
--Possible test cases
testNameRemove :: Test
testNameRemove =
  "nameRemove" ~:
    TestList [
      nameRemove "project" []  ~?= [],
      nameRemove "garbage" [
        Task "homework" "any" 4 "03/03/2023" False,
        Task "garbage" "out" 8 "03/04/2023" False,
        Task "project" "test" 2 "03/28/2023" False
      ]  ~?= [
        Task "homework" "any" 4 "03/03/2023" False,
        Task "project" "test" 2 "03/28/2023" False
      ]
    ]

nameSearch :: String -> TaskList -> Maybe Task
nameSearch _ [] = Nothing
nameSearch name (t : ts)
  | tName t == name = Just t
  | otherwise = nameSearch name ts

testNameSearch :: Test
testNameSearch =
  "nameSearch" ~:
    TestList [
      nameSearch "soccer" []  ~?= Nothing,
      nameSearch "soccer match" [
        Task "homework" "any" 4 "03/03/2023" False,
        Task "garbage" "out" 8 "03/04/2023" False,
        Task "project" "test" 2 "03/28/2023" False
      ]  ~?= Nothing,
      nameSearch "project" [
        Task "homework" "any" 4 "03/03/2023" False,
        Task "garbage" "out" 8 "03/04/2023" False,
        Task "project" "test" 2 "03/28/2023" False
      ]  ~?= Just (Task "project" "test" 2 "03/28/2023" False)
    ]

nameReplace :: String -> Task -> TaskList -> TaskList
nameReplace name task taskList = map(\t -> if tName t == name then task else t) taskList

-- unimplmented siplay tasks function
displayTs :: TaskList -> IO ()
displayTs [] = putStrLn "You have no tasks to display"
displayTs tasks = do
  putStrLn "------------------------------------------------------------"
  putStrLn "Task Name -- Description -- Due Date -- Priority -- Finished"
  putStrLn $ replicate 60 '-'
  mapM_ getTask tasks where
    getTask :: Task -> IO ()
    getTask (Task name description priority ddte complete) = 
      putStrLn $ name ++ " -- " ++ description ++ " -- " ++ ddte ++ " -- " ++ show priority ++ " -- " ++ show complete

replaceTask :: TaskList -> Task -> TaskList
replaceTask taskList newTask = [if tName t == tName newTask then newTask else t | t <- taskList]

markCompleted :: TaskList -> IO TaskList
markCompleted taskList = do
  putStrLn "Enter task name to mark as completed:"
  name <- getLine
  let task = nameSearch name taskList 
  case task of
    Just t -> do
      let completedTask = t {tDesc = "X", dueDate = "X", tPrio = 0, completed = True}
      let updatedList = replaceTask taskList completedTask
      putStrLn $ "Task \"" ++ name ++ "\" is completed."
      return updatedList
    Nothing -> do
      putStrLn $ "There \"" ++ name ++ "\" is no task like that."
      return taskList



-- simple function to start the loop menu for the user.
start :: IO TaskList
start = menu []
