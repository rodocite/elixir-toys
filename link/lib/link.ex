defmodule Link do

  def create(n \\ 20) do
    1..n |> Enum.map(fn _ -> spawn(fn -> loop end) end)
  end

  def loop do
    receive do
      {:link, link_to} when is_pid(link_to) ->
        Process.link(link_to)
        loop

      :to_system_proc ->
        Process.flag(:trap_exit, true)
        loop

      :crash ->
        1/0
    end
  end

  def link(procs) do
    link(procs, [])
  end

  def link([proc_1, proc_2|rest], linked_processes) do
    send(proc_1, {:link, proc_2})
    link([proc_2|rest], [proc_1|linked_processes])
  end

  def link([proc|[]], linked_processes) do
    first_process = linked_processes |> List.last
    send(proc, {:link, first_process})
    :ok
  end

  def links(procs) do
    procs |> Enum.map(fn pid -> "#{inspect pid}: #{inspect Process.info(pid, :links)}" end)
  end

  def crash(procs) do
    procs |> Enum.shuffle |> List.first |> send(:crash)
  end

  def convert(procs) do
    procs
    |> select_random_proc
    |> send(:to_system_proc)
  end

  def status(procs) do
    procs |> Enum.map(fn pid -> {pid, Process.alive?(pid)} end)
  end

  def to_system_proc do
    Process.flag(:trap_exit, true)
  end

  defp select_random_proc(procs) do
    procs |> Enum.shuffle |> List.first
  end
end