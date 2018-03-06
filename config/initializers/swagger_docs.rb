class Swagger::Docs::Config
      def self.base_api_controller; TestingController end
      def self.transform_path(path, api_version); "apidocs/#{path}" end
end

Swagger::Docs::Config.register_apis({
  "testing" => {
    :api_extension_type => nil,
    :api_file_path => "public/apidocs/",
    :base_path => "http://localhost:3000",
    :clean_directory => true,
    :formatting => :pretty,
    :camelize_model_properties => false,
    :controller_base_path => "",
    :parent_controller => TestingController,
    :attributes => {
      :info => {
        "title" => "OOCRAN API",
        "description" => "Apidocs for Open Orchestration Cloud Radio Access Network platform. You can find out more about OOCRAN at https://oocran.github.io.",
        "contact" => ENV['email'],
        "license" => "Apache 2.0",
        "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})

GrapeSwaggerRails.options.app_name    = "OOCRAN API"
GrapeSwaggerRails.options.url         = "/apidocs/api-docs.json"
GrapeSwaggerRails.options.app_url     = ""
