### Chapter 19 - OTP: Applications

Update the `Stack` project from the previous chapter (18) to be a full fledged OTP Application.

1. Update the mix.exs file:

```elixir
def application do
  [
    applications: [:logger],
    mod: { Stack, [1,2,3,4,5] },
    registered: [ Stack.Server ]
  ]
end
```

Additionally accept the argument passed in with `mod` from the `Stack.start` function:

```elixir
def start(_type, initial_list) do
  {:ok, _pid} = Stack.Supervisor.start_link(initial_list)
end
```
---
Then change the application one more time to use Environment variables instead for the `initial_list`:

```elixir
def application do
  [
    applications: [:logger],
    mod: { Stack, [] },
    env: [ initial_list: [1,2,3,4,5] ],
    registered: [ Stack.Server ]
  ]
end
```

```elixir
def start(_type, _args) do
  {:ok, _pid} = Stack.Supervisor.start_link(Application.get_env(:stack, :initial_list))
end
```

### Releasing Code

Using versioning, we can release our project to an external server (in this case, just localhost for the purposes of the exercise).  The first thing to do is add the directive `@vsn "0"` to whatever file you specifically want to version (control).

`lib/stack/server.ex:`
```elixir
defmodule Stack.Server do
  use GenServer

  @vsn "0"

  #...
end
```

Include the dep `exrm` (mix.exs):

```elixir
defp deps do
  [
    {:exrm, "~> 1.0.8"}
  ]
end
```

```
$ mix do deps.get, deps.compile
```

Then finally do a __release__:

```
$ mix release
```
_^ Note: may require `sudo`_

Releases are stored within `rel/project/releases/version/project.tar.gz` so lets copy that to our local ~/deploy and then unzip it:

```
$ cp rel/stack/releases/0.1.0/stack.tar.gz ~/deploy
$ tar -x -f ~/deploy/stack.tar.gz -C ~/deploy
```
_^ Note: the version 0.1.0 comes from the preset value within mix.exs_

With the released deployable project unzipped, lets execute a console:

```
$ cd ~/deploy
$ bin/stack console
Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(stack@127.0.0.1)1> Stack.Server.list
[1, 2, 3, 4, 5]
iex(stack@127.0.0.1)2> Stack.Server.pop
1
iex(stack@127.0.0.1)3> Stack.Server.push(0)
:ok
iex(stack@127.0.0.1)4> Stack.Server.list
[0, 2, 3, 4, 5]
iex(stack@127.0.0.1)5>
```
_^ Note: Leave this session open so we can watch an upgrade release happen in real time!_

Make a small change to the application (in this case `Stack.Server.pop` will now output "The popped item is: [item]") and bump the version within mix.ex (0.1.1).  Then execute another release and deploy the released package.

```
$ mkdir ~/deploy/releases/0.1.1
$ cp rel/stack/releases/0.1.1/stack.tar.gz ~/deploy/releases/0.1.1
$ bin/stack upgrade 0.1.1
Release 0.1.1 not found, attempting to unpack releases/0.1.1/stack.tar.gz
Unpacked successfully: "0.1.1"
Generating vm.args/sys.config for upgrade...
sys.config ready!
vm.args ready!
Release 0.1.1 is already unpacked, now installing.
Installed Release: 0.1.1
Made release permanent: "0.1.1"
```

Test out the new code (switching back to the already running terminal session with the stack console output from before):

```
iex(stack@127.0.0.1)5> Stack.Server.pop
"The popped item is: 0"
iex(stack@127.0.0.1)6>
```

Can easily downgrade to earlier versions too:

```
$ bin/stack downgrade 0.1.0
```

Test again:

```
iex(stack@127.0.0.1)7> Stack.Server.pop
2
```
_Back to normal!_

## Handling State change between versions with GenServer

With all of these upgrade/downgrades with releases how do we handle State changes in a GenServer?  Fortunately GenServer has `code_change` implementation we can use to define the work that needs to be done to convert the previous version's state to the newest versions.

Within `server.ex` change `@vsn "0"` to `@vsn "1"` and this is the value for the first parameter within the `code_change` function:

```elixir
def code_change("0", old_state, _extra) do
  new_state = { old_state, :something_else }
  IO.puts "Changing from version 0 to 1"
  IO.puts "taking the original state, doing something necessary to it"
  IO.puts "and returning a new and improved state:"
  {:ok, new_state }
end
```

Bump the version in mix.exs, issue a release and process the deployment of said release package.  Notice that the `IO.puts` will occur within the existing running window (automatically) after the upgrade.

```
iex(stack@127.0.0.1)14> doing some work to state to prepare it for the newest version

iex(stack@127.0.0.1)15> Stack.Server.list
[1, 2, 3, 4, 5]
iex(stack@127.0.0.1)16>
```
