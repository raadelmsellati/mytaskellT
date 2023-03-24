module PreF where

import Data.List (sortBy)
import Task (Task (..), TaskList)
import Test.HUnit

-- to sort by priority
-- Here i used the function 'sortBy' to help me sort the tasks by
-- its priority from lower to higher. A lambda function passed to
-- sort by that uses the function compare.
prioritySort :: TaskList -> TaskList
prioritySort = sortBy (\t1 t2 -> compare (tPrio t2) (tPrio t1))
-- possible test cases
testprioritySort :: Test
testprioritySort =
  "prioritySort"
    ~: TestList
      [ prioritySort [] ~?= [],
        prioritySort
          [ Task "homework" "any" 4 "03/03/2023" False,
            Task "garbage" "out" 8 "03/04/2023" False,
            Task "project" "test" 2 "03/28/2023" False 
          ]
          ~?= [ Task "garbage" "out" 8 "03/04/2023" False,
                Task "homework" "any" 4 "03/03/2023" False,
                Task "project" "test" 2 "03/28/2023" False
              ]
      ]

-- (Maybe) to retrive highest priority task from the task list
-- I made this function be the help of "head" function. After
-- sorting the taskList by 'prioritySort', we can get the head of it.
-- which is the highest.
priorityHigh :: TaskList -> TaskList
priorityHigh [] = [] --probably not needed since viewTasks does checks that already
priorityHigh taskList = [head $ prioritySort taskList]
--
testpriorityHigh :: Test
testpriorityHigh =
  "priorityHigh"
    ~: TestList
      [ priorityHigh [] ~?= [],
        priorityHigh
          [ Task "homework" "any" 4 "03/03/2023" False,
            Task "garbage" "out" 8 "03/04/2023" False,
            Task "project" "test" 2 "03/28/2023" False
          ]
          ~?= [ Task "garbage" "out" 8 "03/04/2023" False]
      ]

-- (Unimplemneted) priority filter
-- This function filters the list of task by a specific priority
-- It used the filter function to help applying the lambda function
-- on each task of the list. If matches, then filter it. 
priorityFilter :: Int -> TaskList -> TaskList
priorityFilter priority = filter (\t -> tPrio t == priority) 
--
testpriorityFilter :: Test
testpriorityFilter =
  "priorityFilter"
    ~: TestList
      [ priorityFilter 4 [] ~?= [],
        priorityFilter
          8 [ Task "homework" "any" 4 "03/03/2023" False,
            Task "garbage" "out" 8 "03/04/2023" False,
            Task "project" "test" 2 "03/28/2023" False
          ]
          ~?= [ Task "garbage" "out" 8 "03/04/2023" False],

          priorityFilter 5 [Task "Gym" "Legs day" 5 "04/25/2023" False] ~?= [Task "Gym" "Legs day" 5 "04/25/2023" False]
      ]


-- Gets the total number of tasks exist
totalTask :: TaskList -> Int
totalTask = length