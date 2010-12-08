require "spec"
require 'pathname'
require Pathname(__FILE__).dirname.parent.expand_path + 'lib/couchdb_adapter'

# use local copy of dm-core if available
local_dm_core_lib = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'dm-core', 'lib'))
$LOAD_PATH.unshift(local_dm_core_lib) if File.directory?(local_dm_core_lib)

begin
  gem 'dm-serializer'
  require 'dm-serializer'
  DMSERIAL_AVAILABLE = true
rescue LoadError
  DMSERIAL_AVAILABLE = false
end

Spec::Runner.configure do |config|
  config.before(:all) do
    @adapter = DataMapper.setup(:default, "couchdb://localhost:5984/test_cdb_adapter")
    @repository = DataMapper.repository(@adapter.name)
  end
end