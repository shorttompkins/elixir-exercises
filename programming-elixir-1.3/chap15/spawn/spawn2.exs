defmodule Spawn2 do
  def greet do
    receive do
      { sender, message } ->
        send sender, { :ok, "Hello #{message}" }
    end
  end
end

pid = spawn(Spawn2, :greet, [])
send(pid, { self, "World!" })

receive do
  { :ok, message } -> IO.puts message
end

send(pid, { self, "Kermit!" })
receive do
  { :ok, message } -> IO.puts message 
end
