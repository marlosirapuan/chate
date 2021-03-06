defmodule ChateWeb.RoomChannel do
  use ChateWeb, :channel

  alias Chate.Coherence.User
  alias Chate.Repo
  alias Chate.Message
  alias ChateWeb.Presence

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    {:ok, msg} =
      Message.changeset(%Message{user_id: socket.assigns[:user]}, payload)
      |> Repo.insert()

    broadcast(socket, "shout", Map.put_new(payload, :name, Repo.get(User, msg.user_id).name))
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    user = Repo.get(User, socket.assigns[:user])
    {:ok, _} = Presence.track(socket, user.name, %{online_at: inspect(System.system_time(:seconds))})
    push socket, "presence_state", Presence.list(socket)

    Message.get_messages()
    |> Enum.each(fn msg -> push(socket, "shout", %{name: Repo.get(User, msg.user_id).name, message: msg.message})end)

    {:noreply, socket} # :noreply
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp get_messages_and_add_presence(s) do
    IO.inspect s
  end
end
