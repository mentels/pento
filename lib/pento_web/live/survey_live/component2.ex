defmodule PentoWeb.SurveyLive.Component2 do
  use Phoenix.Component

  attr :title, :string, required: true
  attr :heading, :string, required: true
  attr :message, :string, required: true

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="font-heavy text-3xl">
        <%= @title %>
      </h1>
      <h2 class="font-medium text-2xl">
        <%= @heading %>
      </h2>
      <p class="font-normal">
        <%= @message %>
      </p>
    </div>
    """
  end
end
