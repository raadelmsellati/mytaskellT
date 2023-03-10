module PreF where

import Task (Task (..), TaskList)
import Test.HUnit

-- to sort by priority
prioritySort :: TaskList -> TaskList
prioritySort = undefined

-- possible test cases
testprioritySort :: Test
testprioritySort =
  "prioritySort"
    ~: TestList
      [ prioritySort [] ~?= [],
        prioritySort
          [ Task "homework" "any" 4 "03/03/2023",
            Task "garbage" "out" 8 "03/04/2023",
            Task "project" "test" 2 "03/28/2023"
          ]
          ~?= [ Task "garbage" "out" 8 "03/04/2023",
                Task "homework" "any" 4 "03/03/2023",
                Task "project" "test" 2 "03/28/2023"
              ]
      ]

-- (Maybe) to retrive highest priority task from the task list
priorityHigh :: TaskList -> Maybe Task
priorityHigh = undefined

-- (Unimplemneted) priority filter
priorityFilter :: Int -> TaskList -> TaskList
priorityFilter = undefined

totalTask :: TaskList -> Int
totalTask = length