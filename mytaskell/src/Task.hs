module Task (Task (..), TaskList) where

data Task = Task
  { tName :: String,
    tDesc :: String,
    tPrio :: Int,
    dueDate :: String
  }
  deriving (Eq, Show)

type TaskList = [Task]