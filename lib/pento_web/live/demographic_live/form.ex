defmodule PentoWeb.DemographicLive.Form do
  use PentoWeb, :live_component
  alias Pento.Survey
  alias Pento.Survey.Demographic

  ### CALLBACKS ###

  def update(assigns, socket) do
    socket
    |> assign(assigns)
    |> assign_demographic()
    |> clear_form()
    |> then(&{:ok, &1})
  end

  def handle_event("save", %{"demographic" => demographic_params}, socket) do
    params = with_user_id(demographic_params, socket)
    {:noreply, save_demographic(socket, params)}
  end

  ### HELPERS ###

  defp assign_demographic(socket) do
    assign(socket, :demographic, %Demographic{user_id: socket.assigns.current_user.id})
  end

  defp clear_form(socket) do
    # the user_id is not part of the form and ends up in the changeset data
    assign_form(socket, Survey.change_demographic(socket.assigns.demographic))
  end

  defp assign_form(socket, changeset) do
    # here we loose the user_id as we don't pass it to the form
    assign(socket, :form, to_form(changeset))
  end

  defp save_demographic(socket, demographic_params) do
    case Survey.create_demographic(demographic_params) do
      {:ok, demographic} ->
        send(self(), {:demographic_created, demographic})
        socket

      {:error, changeset} ->
        assign_form(socket, changeset)
    end
  end

  defp with_user_id(demographic_params, socket) do
    Map.put(demographic_params, "user_id", socket.assigns.current_user.id)
  end
end
