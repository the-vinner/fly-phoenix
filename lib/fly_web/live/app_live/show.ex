defmodule FlyWeb.AppLive.Show do
  use FlyWeb, :live_view
  require Logger

  alias Fly.Client
  alias FlyWeb.Components.App
  alias FlyWeb.Components.HeaderBreadcrumbs
  alias FlyWeb.Components.Headings

  defp client_config(session) do
    Fly.Client.config(access_token: session["auth_token"] || System.get_env("FLYIO_ACCESS_TOKEN"))
  end

  defp fetch_app(socket) do
    app_name = socket.assigns.app_name

    case Client.fetch_app(app_name, socket.assigns.config) do
      {:ok, app} ->
        assign(socket, :app, app)

      {:error, :unauthorized} ->
        put_flash(socket, :error, "Not authenticated")

      {:error, reason} ->
        Logger.error("Failed to load app '#{inspect(app_name)}'. Reason: #{inspect(reason)}")

        put_flash(socket, :error, reason)
    end
  end

  @spec format_allocation_checks(any) :: binary
  def format_allocation_checks(checks) when is_list(checks) do
    checks
    |> Enum.reduce([0, 0], fn c, [total, passing] ->
      [
        total + 1,
        passing + (c["status"] === "passing" && 1 || 0)
      ]
    end)
    |> then(fn [total, passing] ->
      "#{total} total, #{passing} passing"
    end)
  end
  def format_allocation_checks(_), do: ""

  def format_process_group_regions([]), do: "-"
  def format_process_group_regions(regions) when is_list(regions), do: Enum.join(regions, ", ")
  def format_process_group_regions(_), do: "-"

  def format_timestamp(ts) do
    with {:ok, ts} <- Timex.parse(ts, "{ISO:Extended}"),
      {:ok, ts} <- Timex.format(ts, "{relative}", :relative) do
     ts
    else
      _ -> ts
    end
  end

  @impl true
  def mount(%{"name" => name}, session, socket) do
    socket =
      assign(socket,
        config: client_config(session),
        state: :loading,
        app: nil,
        app_name: name,
        count: 0,
        authenticated: true
      )

    # Only make the API call if the websocket is setup. Not on initial render.
    if connected?(socket) do
      {:ok, fetch_app(socket)}
    else
      {:ok, socket}
    end
  end


  @impl true
  def handle_event("click", _params, socket) do
    {:noreply, assign(socket, count: socket.assigns.count + 1)}
  end

  def handle_event("refresh", _params, socket) do
    {:noreply, fetch_app(socket)}
  end

  def labels_allocations do
    ["Task", "Version", "Region", "Desired", "Status", "Health Checks", "Restarts", "Created", "ID"]
  end

  def preview_url(app) do
    "https://#{app["name"]}.fly.dev"
  end

  def status_bg_color(app) do
    case app["status"] do
      "running" -> "bg-green-100"
      "dead" -> "bg-red-100"
      _ -> "bg-yellow-100"
    end
  end

  def status_text_color(app) do
    case app["status"] do
      "running" -> "text-green-800"
      "dead" -> "text-red-800"
      _ -> "text-yellow-800"
    end
  end

  def status_deployment_bg_color(deployment) do
    case deployment["status"] do
      "successful" -> "bg-green-100"
      "failed" -> "bg-red-100"
      _ -> "bg-yellow-100"
    end
  end

  @spec status_deployment_text_color(nil | maybe_improper_list | map) :: <<_::64, _::_*8>>
  def status_deployment_text_color(deployment) do
    case deployment["status"] do
      "successful" -> "text-green-800"
      "failed" -> "text-red-800"
      _ -> "text-yellow-800"
    end
  end
end
