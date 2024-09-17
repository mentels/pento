defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_recipient() |> clear_form()}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket |> assign_recipient() |> clear_form()}
  end

  def handle_event("validate", %{"recipient" => recipient_params}, socket) do
    socket.assigns.recipient
    |> Promo.change_recipient(recipient_params)
    |> then(&assign_form(socket, Map.put(&1, :action, :validate)))
    |> then(&{:noreply, &1})
  end

  def handle_event("save", %{"recipient" => recipient_params}, socket) do
    # Simulate network latency
    Process.sleep(1000)

    case Promo.send_promo(socket.assigns.recipient, recipient_params) do
      {:ok, recipient} ->
        socket
        |> put_flash(:info, "Promo sent to #{recipient.first_name}!")
        # hoped it would "reset" the form so that the errors are only shown on fields that has been edited
        # https://github.com/phoenixframework/phoenix_live_view/issues/3071
        # https://hexdocs.pm/phoenix_live_view/0.20.17/Phoenix.Component.html#form/1-a-note-on-errors
        # https://elixirforum.com/t/how-does-liveview-keep-track-of-which-forms-fields-have-been-altered/56014/3
        |> push_patch(to: ~p"/promo")
        |> then(&{:noreply, &1})

      {:error, changeset} ->
        socket
        |> assign_form(Map.put(changeset, :action, :validate))
        |> then(&{:noreply, &1})
    end
  end

  defp assign_recipient(socket) do
    assign(socket, recipient: %Recipient{})
  end

  defp clear_form(socket) do
    assign_form(socket, Promo.change_recipient(socket.assigns.recipient))
  end

  defp assign_form(socket, changeset) do
    # Converts a given data structure to a Phoenix.HTML.Form.
    assign(socket, form: to_form(changeset))
  end
end
