defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_collection) do
    IO.puts "Supervisor.start_link"
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_collection])
    start_workers(sup, initial_collection)
  end

  def start_workers(sup, initial_collection) do
    IO.puts "Supervisor.start_workers"
    {:ok, stash} = Supervisor.start_child(sup, worker(Stack.Stash, [initial_collection]))
    Supervisor.start_child(sup, supervisor(Stack.SubSupervisor, [stash]))
  end

  def init(_) do
    IO.puts "Supervisor.init"
    supervise([], strategy: :one_for_one)
  end
end
