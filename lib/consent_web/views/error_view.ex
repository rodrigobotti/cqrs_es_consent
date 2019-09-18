defmodule ConsentWeb.ErrorView do
  use ConsentWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("422.json", assigns) do
    %{
      code: "UNPROCESSABLE_ENTITY",
      status_code: 422,
      error: assigns[:error] || "Unprocessable entity",
      message: assigns[:message] || "Unprocessable entity"
    }
  end
end
