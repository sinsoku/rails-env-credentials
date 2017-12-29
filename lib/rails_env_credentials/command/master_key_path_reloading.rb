# frozen_string_literal: true

module RailsEnvCredentials
  module MasterKeyPathReloading
    def add_master_key_file
      self.class.send(:remove_const, :MASTER_KEY_PATH)
      self.class.const_set(:MASTER_KEY_PATH, Pathname.new(RailsEnvCredentials.key_path))
      super
    end
  end
end
