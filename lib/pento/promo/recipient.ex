defmodule Pento.Promo.Recipient do
  alias Ecto.Changeset
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :first_name, :string
    field :email, :string
  end

  @spec changeset(Recipient.t(), map()) :: Changeset.t()
  def changeset(%__MODULE__{} = recipient, attrs) do
    recipient
    |> cast(attrs, [:first_name, :email])
    |> validate_required([:first_name, :email])
    |> validate_format(:email, ~r/@/)
  end

  @spec apply_changes(Changeset.t()) :: {:ok, Recipient.t()} | {:error, Changeset.t()}
  def apply_changes(%Changeset{} = changeset) do
    apply_action(changeset, :update)
  end
end
