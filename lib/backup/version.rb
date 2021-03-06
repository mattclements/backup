# encoding: utf-8

module Backup
  class Version

    ##
    # Change the MAJOR, MINOR and PATCH constants below
    # to adjust the version of the Backup gem
    #
    # MAJOR:
    #  Defines the major version
    # MINOR:
    #  Defines the minor version
    # PATCH:
    #  Defines the patch version
    MAJOR, MINOR, PATCH, ENGINE_YARD_VERSION = 3, 0, 27, 4

    ##
    # Returns the major version ( big release based off of multiple minor releases )
    def self.major
      MAJOR
    end

    ##
    # Returns the minor version ( small release based off of multiple patches )
    def self.minor
      MINOR
    end

    ##
    # Returns the patch version ( updates, features and (crucial) bug fixes )
    def self.patch
      PATCH
    end

    ##
    # Returns the engine_yard patch version
    def self.engine_yard_version
      ENGINE_YARD_VERSION
    end

    ##
    # Returns the current version of the Backup gem ( qualified for the gemspec )
    def self.current
      "#{major}.#{minor}.#{patch}.#{engine_yard_version}"
    end

  end
end
