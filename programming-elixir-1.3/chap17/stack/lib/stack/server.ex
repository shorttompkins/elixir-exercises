defmodule Stack.Server do
  use GenServer


  #####
  # External API

  def start_link(collection) do
    GenServer.start_link(__MODULE__, collection, name: __MODULE__)
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

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_call(:list, _from, collection) do
    { :reply, collection, collection }
  end

  def handle_cast({:push, item}, collection) do
    { :noreply, [item] ++ collection }
  end

  def terminate(reason, state) do
    IO.puts "Stack.Server terminated because: #{reason}."
    IO.inspect state
  end

end
