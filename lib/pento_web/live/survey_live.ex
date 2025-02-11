defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias Pento.Survey
  alias PentoWeb.DemographicLive
  # Experiments
  alias PentoWeb.SurveyLive.Component
  alias PentoWeb.SurveyLive.Component2

  def mount(_params, _session, socket) do
    {:ok, assign_demographic(socket)}
  end

  def handle_info({:demographic_created, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  defp assign_demographic(socket),
    do: assign(socket, :demographic, Survey.get_demographic_by_user(socket.assigns.current_user))

  defp handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully.")
    |> assign(:demographic, demographic)
  end
end
