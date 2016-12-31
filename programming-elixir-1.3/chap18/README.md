### Chapter 18 - OTP: Supervisors

Implement a `Stash` GenServer that is under a sub-supervisor umbrella of supervisors so that if the main GenServer fails (Stack) it will push the current stack to the stash so that it can be retrieved when the Stack server restarts.

* stack.ex: Calls Stack.Supervisor.start_link passing it the initial collection for the stack
* Stack.Supervisor.start_link accepts the initial collection, and triggers a Supervisor.start_link (unfortunately, not to be confised with the actual module we created) which accepts the current module (__MODULE__) and the array of parameters, namely the first and only being the initial_collection
* call `start_workers` which boots up the Supervisor children for the SubSupervisor
* Supervisor.start_child (is similar to start_link) accepts the pid for a parent supervisor (the main one in our case), and a worker (which is basically a way of triggering `GenServer.start_link(Module, initial_state)`).  The returning pid is the pid for our Stash (as the `Stack.Stash` was triggered within the worker call)
* Finally, start another Supervisor specifically for the SubSupervisor (note the use of `supervisor` instead of `worker` - the actual `worker` gets triggered within the SubSupervisor)
* `SubSupervisor.start_link` accepts the stash's pid and triggers the main worker for our `Stack` (passing in the stash_pid instead of the initial collection - because whenever Stack starts, its going to request the initial_collection from the Stash)
* Stack.Stash start_link accepts any value (in our case the array of the collection, passed in from when the app first starts)
* Additionally `Stack.Stash.save_value/get_value` simply works with its own state, again in this case is just our collection array being passed back and forth from `Stack.Server`
* `Stack.Server` has been tweaked to always passing around a tuple that contains both the current state as well as the `stash_pid` so that at any time the stash_pid can be used to save the current_state (within `terminate`)
  * Mainly the GenServer implementation has been adjusted to use the tuple.  Specifically we added `init` that retrieves the current_list from the Stash when `Stack.Server` is initialized (i.e. first run and after any termination)
  * handle_call, handle_cast, and terminate all now accept a tuple instead of just the original array for the collection, ensuring that the stash_pid is always the 2nd field in the tuple.
* `terminate` will call `Stack.Stash.save_value(current_list)` so that the Stash saves our last good state before the Supervisor restarts Stack.Server (recycling its init process and retrieving the current_list from the Stash)
