local todo_file = "todolist.txt"

local function clear_buffer()
	io.write("\027[2J")
	io.write("\027[H")
end

-- Load tasks from file
local function load_tasks()
    local tasks = {}
    local file = io.open(todo_file, "r")
    if file then
        for line in file:lines() do
            table.insert(tasks, line)
        end
        file:close()
    end
    return tasks
end

-- Save tasks to file
local function save_tasks(tasks)
    local file = io.open(todo_file, "w")
    for _, task in ipairs(tasks) do
        file:write(task .. "\n")
    end
    file:close()
end

-- Add a new task
local function add_task(tasks, task)
    table.insert(tasks, task)
    print("Task added: " .. task)
end

-- List tasks
local function list_tasks(tasks)
    if #tasks == 0 then
        print("No tasks available.")
    else
        print("Tasks:")
        for i, task in ipairs(tasks) do
            print(i .. ". " .. task)
        end
    end
end

-- Remove a task
local function remove_task(tasks, index)
    if tasks[index] then
        print("Task removed: " .. tasks[index])
        table.remove(tasks, index)
    else
        print("Invalid task number.")
    end
end

-- Main loop
local function main()
    local tasks = load_tasks()
    while true do
        print("\n1. List Tasks")
        print("2. Add Task")
        print("3. Remove Task")
        print("4. Exit")
        io.write("Make your choice: ")
        local choice = io.read()

        if choice == "1" then
			clear_buffer()
            list_tasks(tasks)
        elseif choice == "2" then
			clear_buffer()
            io.write("Enter the task to add: ")
            local task = io.read()
            add_task(tasks, task)
            save_tasks(tasks)
        elseif choice == "3" then
			clear_buffer()
            list_tasks(tasks)
            io.write("Enter the task number to remove: ")
            local index = tonumber(io.read())
            if index then
                remove_task(tasks, index)
                save_tasks(tasks)
            else
                print("Invalid input.")
            end
        elseif choice == "4" then
			clear_buffer()
            print("Exiting...")
            break
        else
			clear_buffer()
            print("Invalid choice.")
        end
    end
end

main()
