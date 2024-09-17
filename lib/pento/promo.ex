defmodule Pento.Promo do
  @moduledoc """
  Deal with uncertainty.
  """
  alias Pento.Promo.Recipient

  require Logger

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  @spec send_promo(Recipient.t(), map()) :: {:ok, Recipient.t()} | {:error, Changeset.t()}
  def send_promo(%Recipient{} = recipient, attrs) do
    recipient
    |> Recipient.changeset(attrs)
    |> Recipient.apply_changes()
    |> case do
      {:ok, recipient} ->
        send_promo(recipient)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp send_promo(%Recipient{} = recipient) do
    Logger.info("Sending promo to #{recipient.first_name} (#{recipient.email})")
    {:ok, recipient}
  end
end
