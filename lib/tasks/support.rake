namespace :development do
  desc 'Fetch production database to development'
  task pulldb: :environment do
    db_name = YAML.load_file('config/database.yml')['development']['database']

    system 'heroku pg:backups capture --app smidig2016'
    system 'curl -o latest.dump `heroku pg:backups public-url --app smidig2016`'
    system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{db_name} latest.dump"
    system 'rm latest.dump'
  end
end

