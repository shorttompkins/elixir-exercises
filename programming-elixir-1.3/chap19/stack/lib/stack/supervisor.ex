defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_collection) do
    {:ok, sup_pid} = Supervisor.start_link(__MODULE__, [initial_collection])
    start_workers(sup_pid, initial_collection)
  end

  def start_workers(sup_pid, initial_collection) do
    {:ok, stash_pid} = Supervisor.start_child(sup_pid, worker(Stack.Stash, [initial_collection]))
    Supervisor.start_child(sup_pid, supervisor(Stack.SubSupervisor, [stash_pid]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
