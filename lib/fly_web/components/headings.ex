defmodule FlyWeb.Components.Headings do
  import Phoenix.LiveView, only: [assign: 3], warn: false
  import Phoenix.LiveView.Helpers

  def table_heading(assigns) do
    ~H"""
    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
      <%= render_block(@inner_block) %>
    </th>
    """
  end

  def title(assigns) do
    ~H"""
    <h2 class="text-lg leading-6 font-medium text-gray-900">
      <%= render_block(@inner_block) %>
    </h2>
    """
  end
end
