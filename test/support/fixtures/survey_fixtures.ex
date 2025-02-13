defmodule Pento.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Survey` context.
  """

  import Pento.AccountsFixtures
  import Pento.CatalogFixtures

  @doc """
  Generate a demographic.
  """
  def demographic_fixture(attrs \\ %{}) do
    {:ok, demographic} =
      attrs
      |> Enum.into(%{
        gender: "male",
        year_of_birth: 2018,
        user_id: user_fixture().id
      })
      |> Pento.Survey.create_demographic()

    demographic
  end

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    {:ok, rating} =
      attrs
      |> Enum.into(%{
        stars: 4,
        user_id: user_fixture().id,
        product_id: product_fixture().id
      })
      |> Pento.Survey.create_rating()

    rating
  end
end
