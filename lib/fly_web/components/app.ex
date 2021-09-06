defmodule FlyWeb.Components.App do
  import Phoenix.LiveView, only: [assign: 3], warn: false
  import Phoenix.LiveView.Helpers
  alias FlyWeb.Components.Headings

  def allocation(assigns) do
    ~H"""
    <tr>
      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
        <%= @task %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @version %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @region %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @desired_status %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @status %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @checks %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @restarts %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @created_at %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @id %>
      </td>
    </tr>
    """
  end

  def container_group(assigns) do
    ~H"""
    <section
      class="bg-white shadow sm:rounded-lg"
    >
      <div class="px-4 py-5 sm:px-6">
        <Headings.title>
          <%= @title %>
        </Headings.title>
      </div>
      <div class="border-t border-gray-200">
        <div class="sm:col-span-2">
          <dd class="text-sm text-gray-900">
            <div class="flex flex-col pb-5">
              <div class="-my-2 overflow-x-auto">
                <div class="py-2 align-middle inline-block min-w-full">
                  <%= render_block(@inner_block) %>
                </div>
              </div>
            </div>
          </dd>
        </div>
      </div>
    </section>
    """
  end

  def process_group(assigns) do
    ~H"""
    <tr>
      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
        <%= @name %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
        <%= @regions %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <%= @vm_size_name %>
      </td>
    </tr>
    """
  end

  def release(assigns) do
    ~H"""
      <li class="px-8">
      <div class="relative py-4">
        <div class="relative flex items-center space-x-3">
          <div>
            <span class="h-8 w-8 rounded-full bg-gray-400 flex items-center justify-center ring-8 ring-white">
              <%= if not is_nil(@user) do %>
                <img class="inline-block h-8 w-8 rounded-full" src={@user["avatarUrl"]} alt="">
              <% else %>
                <!-- Heroicon name: solid/user -->
                <svg class="w-5 h-5 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                  <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
                </svg>
              <% end %>
            </span>
          </div>
          <div class="min-w-0 flex-1 flex gap-2 space-x-4">
            <div>
              <p class="text-sm text-gray-500">v<%= @version %></p>
            </div>
            <%= if @stable do %>
              <p class="text-green-800">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
              </p>
            <% else %>
              <p class="text-red-800">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                </svg>
              </p>
            <% end %>
            <div>
              <p class="text-sm text-gray-500"><%= @reason %></p>
            </div>
            <div class="flex-grow text-right text-sm whitespace-nowrap text-gray-500">
              <time datetime="2020-09-20"><%= @created_at %></time>
            </div>
          </div>
        </div>
      </div>
    </li>
    """
  end
end
