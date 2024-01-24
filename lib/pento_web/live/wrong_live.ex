defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply,
     assign(socket,
       score: 0,
       number: number(),
       status: :playing,
       message: "Make a guess:",
       time: nil
     )}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    if socket.assigns.number == String.to_integer(guess) do
      message = "Your guess: #{guess}. Correct!"
      score = socket.assigns.score + 1
      time = time()
      {:noreply, assign(socket, score: score, message: message, time: time, status: :won)}
    else
      message = "Your guess: #{guess}. Wrong! Guess again."
      score = socket.assigns.score - 1
      time = time()
      {:noreply, assign(socket, score: score, message: message, time: time, status: :lost)}
    end
  end

  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2>
      <div><%= @message %></div>
      <div :if={@time}>It's <%= @time %></div>
    </h2>
    <br />
    <h2 :if={@status == :playing}>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-bule-700 text-white font-bold py-2 px-4 border border-bule-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}
        >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    <h2 :if={@status != :playing}>
      <.link
        class="bg-blue-500 hover:bg-bule-700 text-white font-bold py-2 px-4 border border-bule-700 rounded m-1"
        patch={~p"/guess"}
      >
        Restart
      </.link>
    </h2>
    """
  end

  def time, do: DateTime.utc_now() |> to_string()

  def number, do: Enum.random(1..10)
end
