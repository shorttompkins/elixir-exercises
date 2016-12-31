defmodule Stack.Server do
  use GenServer


  #####
  # External API

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  def list do
    GenServer.call(__MODULE__, :list)
  end


  #####
  # GenServer Implementation

  def init(stash_pid) do
    current_list = Stack.Stash.get_value(stash_pid)
    { :ok, {current_list, stash_pid} }
  end

  def handle_call(:pop, _from, {[head | tail], stash_pid}) do
    { :reply, head, {tail, stash_pid} }
  end

  def handle_call(:list, _from, {collection, stash_pid}) do
    { :reply, collection, {collection, stash_pid} }
  end

  # added the guard so could easily force termination via `Stack.Server.push("cat")` ;)
  def handle_cast({:push, item}, {collection, stash_pid}) when is_number(item) do
    { :noreply, {[item] ++ collection, stash_pid} }
  end

  def terminate(reason, {current_list, stash_pid}) do
    Stack.Stash.save_value(stash_pid, current_list)
    IO.puts "Stack.Server terminated because: #{reason}."
  end

end
