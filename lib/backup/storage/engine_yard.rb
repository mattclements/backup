# encoding: utf-8

##
# Only load the Fog gem when the Backup::Storage::Engineyard class is loaded
Backup::Dependency.load('ey-core')

module Backup
  module Storage
    class EngineYard < Base

      ##
      # Engine Yard Instance Credentials
      attr_accessor :instance_token
      
      ##
      # Core API URL 
      attr_accessor :core_api_url

      ##
      # Creates a new instance of the storage object
      def initialize(model, storage_id = nil, &block)
        super(model, storage_id)

        instance_eval(&block) if block_given?
      end

      private

      def connection
        #send core-client a request with a given token, receive a url
        @connection ||= Ey::Core::Client.new(
          :token        => instance_token,
          :core_api_url => core_api_url,
        )
      end

      ##
      # Transfers the archived file to the specified container
      def transfer!
        backup = connection.backups.create

        files_to_transfer_for(@package) do |local_file, remote_file|
          Logger.message "#{storage_name} started transferring " +
            "'#{local_file}' to url '#{post_url}'."

          File.open(File.join(local_path, local_file), 'r') do |file|
            backup.files.create(file)
          end
        end
      end

      ##
      # Removes the transferred archive file(s) from the storage location.
      # Any error raised will be rescued during Cycling
      # and a warning will be logged, containing the error message.
      def remove!(package)
        remote_path = remote_path_for(package)

        messages = []
        transferred_files_for(package) do |local_file, remote_file|
          messages << "#{storage_name} started removing '#{ local_file }'."
        end
        Logger.message messages.join("\n")

        FileUtils.rm_r(remote_path)
      end

    end
  end
end

