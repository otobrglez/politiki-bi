# By Oto Brglez - <oto.brglez@opalab.com>

require "./lib/manager"

m = Manager.new

desc "Migrate the database through scripts in ./migrations. Target specific version with VERSION=x"
task :migrate do
	ActiveRecord::Migrator.migrate('migrations', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

desc "Dump schema.db"
task :dump_schema do
	ActiveRecord::Base.logger = Logger.new("/dev/null")
	ActiveRecord::SchemaDumper.dump
end

desc "PErform MDX query"
task :mdx do

	query = ""
	unless $stdin.tty?
	  $stdin.each_line do |line|
	    query << line
	  end
	end
	
	begin
		result = m.olap.execute query
	rescue Mondrian::OLAP::Error => e
		puts e.root_cause
	end

	puts result.to_html
end