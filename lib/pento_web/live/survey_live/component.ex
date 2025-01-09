defmodule PentoWeb.SurveyLive.Component do
  use Phoenix.Component

  def ul(assigns) do
    ~H"""
    <ul>
      <%= for item <- @items do %>
        <.li><%= item %></.li>
      <% end %>
    </ul>
    """
  end

  def li(assigns) do
    ~H"""
    <li>
      <%= render_slot(@inner_block) %>
    </li>
    """
  end

  def ul2(assigns) do
    ~H"""
    <ul :for={item <- @items}>
      <.li2 item={item} inner_block={@inner_block} />
      <%!-- below doesn't work --%>
      <%!-- <.li2 item={item}><%= @inner_block %></.li2> --%>
      <%!-- <li><%= render_slot(@inner_block, item) %></li> --%>
    </ul>
    """
  end

  def li2(assigns) do
    ~H"""
    <li>
      <%= render_slot(@inner_block, @item) %>
    </li>
    """
  end

  attr :content, :string, required: true
  slot :inner_block, required: true

  def hero(assigns) do
    ~H"""
    <h1 class="font-heavy text-3xl">
      <%= @content %>
    </h1>
    <h3>
      <%= render_slot(@inner_block) %>
    </h3>
    <%!-- <pre>
      <%= inspect(assigns, pretty: true) %>
      <% %{ inner_block: [%{inner_block: block_fn}] } = assigns %>
      <%= inspect(block_fn.(assigns.__changed__, assigns), pretty: true) %>
      <% %{dynamic: dynamic} = block_fn.(assigns.__changed__, assigns) %>
      dynamic: <%= inspect(dynamic.(assigns), pretty: true) %>
    </pre> --%>
    """
  end
end
