module Task (Task (..), TaskList) where

data Task = Task
  { tName :: String,
    tDesc :: String,
    tPrio :: Int,
    dueDate :: String,
    completed :: Bool
  }
  deriving (Eq, Show)

type TaskList = [Task]