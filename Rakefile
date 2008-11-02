# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load "tasks/setup.rb"

ensure_in_path "lib"
require "netflix"

task :default => "spec:run"

PROJ.name = "netflix"
PROJ.authors = "Rob Ares"
PROJ.email = "rob.ares@gmail.com"
PROJ.url = "http://www.robares.com"
PROJ.rubyforge.name = "netflix"

PROJ.spec.opts << "--color"

# EOF
