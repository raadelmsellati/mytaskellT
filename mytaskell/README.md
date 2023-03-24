# MyTASKELL

MyTaskell, is a command-line tool works as a task manager enables users to manage their 
to-do lists and tasks. Users can see their tasks by several criteria, such as due date or priority, and 
add, change, and delete tasks as needed. This program is written in Haskell and The Stack tool.

# Features:
   * A command-line interface will be used by MyTaskell's user interface, which will consist of a number of menus and prompts.
   * Task creation: Users can add tasks to their task list by giving it a Name, description, DueDate, priority.
   * Users have the ability to modify current tasks by modifying its Name, description, dueDate, and priority.
   * Users have the option of deleting tasks from their task list by name.
   * Users can sort the tasks in their list by priority, Low TO High.
   * Users are able to filter their list of tasks by a specific prioirty. If prio = 8, then view only all the tasks with 8 prio.
   * Users can label their task as finished after it is done.

# How to use?
   first:
   
      stack build
      stack run
   
   You will have a basic interface with different options that you can use.
   
      * -add (Add a new task)
      * -edit (Edit an existed task)
      * -remove (Remove an existed task)
      * -view (Display existed tasks)
      * -high (Get the the most important task 'recent added')
      * -sort (Sort tasks by priority Low To High)
      * -priority (Filter tasks by priority)
      * -count (Get total number of existed tasks)
      * -mark (mark as finished)
      * -quit
      
   After 'quit' the program will output the test cases with their results using Test.HUnit.
   
      for example: Cases: 7  Tried: 7  Errors: 0  Failures: 0


## Source Code:
   # Modules:
   The modules till the current moment of developing MyTaskell are about 4 modules and all of them depend on each other. So far I have the modules: Task, TList, PerF, and Main.
   
      * Task:
   This module is responsible of holding the data types of the program such as Task and TaskList. All of the other modules are required to import this module to deal with the data types needed.
    
      * TList:
   
   Basically, this module is the core module for the basic operations such as add task, modify, remove, and display tasks. 
   This module also is imported by other modules such as main because it has the menu loop and the start function of the program.
        
        * PerF:
   This module is responsible for holding user preference functions. These include functions such as count all tasks, get the highest priority task, sort by tasks by priority, etc. 
   Task module is imported in this module to deal with data types. 
    
         * Main:
   Responsible for kicking off the program and start the testing process quitting the program using Test.HUnit library.

# Testing
Testing method used for thie porgram is via Test.HUnit. It is used by implementing test function version for some main functions in the program. For example, prioritySort would have a function "testPrioritySort" with test cases within that function.

- Credits: <a href="https://github.com/raadelmsellati" target="blank"> raadelmsellati </a>
