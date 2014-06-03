module S3Wrapper

  class << self

    def config
      @config ||= YAML.load_file(Rails.root.join('config', 's3.yml')).symbolize_keys
    end

    %w[aws_access_key_id aws_secret_access_key bucket prefix local_dir].each do |entity|
      define_method(entity) do
        ENV[entity.upcase] || config[entity.to_sym]
      end
    end

  end

end
