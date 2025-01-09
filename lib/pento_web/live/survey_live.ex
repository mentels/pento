defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias Pento.Survey
  alias PentoWeb.DemographicLive
  alias PentoWeb.SurveyLive.Component
  alias PentoWeb.SurveyLive.Component2

  def mount(_params, _session, socket) do
    {:ok, assign_demographic(socket)}
  end

  defp assign_demographic(socket),
    do: assign(socket, :demographic, Survey.get_demographic_by_user(socket.assigns.current_user))
end
