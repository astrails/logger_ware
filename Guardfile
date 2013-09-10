guard 'bundler' do
  watch 'Gemfile'
  watch 'logger_ware.gemspec'
end

guard :rspec, cli: '--color --format nested' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
